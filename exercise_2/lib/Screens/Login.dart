import 'dart:async';

import 'package:exercise_2/Providers/User.dart';
import 'package:exercise_2/Utils/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<Login> {
  Helper helper = Helper();
  bool isLoading = false;
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.green,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff36332e),
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (val) {
        if (val!.isEmpty && !val.contains("@")) {
          setState(() {
            isLoading = false;
          });
          return "Please enter the email";
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9,@,a-z,A-Z,.]"))
      ],
      onSaved: (value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff36332e), width: 4.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      obscureText: true,
      controller: _passwordController,
      validator: (val) {
        if (val!.isEmpty) {
          setState(() {
            isLoading = false;
          });
          return "Please enter the password";
        }
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9,@#*&^%?/>< a-z A-Z ]"))
      ],
      onSaved: (value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      activeColor: Colors.green,
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: GestureDetector(
        onTap: () => {},
        child: Text('Accept Terms',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _submitForm(Function authenticate) async {
    setState(() {
      isLoading = true;
    });

    Timer(Duration(seconds: 2), () async {
      if (!_formKey.currentState!.validate() || !_formData['acceptTerms']) {
        return;
      }
      _formKey.currentState!.save();
      bool successInformation;

      successInformation =
          await authenticate(_formData['email'], _formData['password']);

      if (successInformation) {
        setState(() {
          helper.addTokenToLocale();
          isLoading = false;
        });

        context.read<UserActivityModel>().token = 'logged_in_already';
        context.read<UserActivityModel>().loggedIn();

        Navigator.pushReplacementNamed(context, 'DashboardScreen');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An Error Occured'),
              content: Text('Wrong pass or email'),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      context.read<UserActivityModel>().token = 'not_loggedIn';
                      Navigator.of(context).pop();
                    },
                    child: Text('Okay'))
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      backgroundColor: Colors.white, //Color(0xfff2e1cf),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          toolbarHeight: 80,
          title: Text(
            'Exercise 1',
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )

          // centerTitle: true,

          ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    // _buildBackgroundImage(),

                    Container(
                      height: 100,
                    ),

                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),

                    SizedBox(
                      height: 10.0,
                    ),
                    _buildAcceptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('     Login     '),
                      onPressed: () => _submitForm(helper.authenticate),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20, color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
