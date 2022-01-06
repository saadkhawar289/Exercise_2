import 'package:exercise_2/Utils/Helpers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/User.dart';
import 'Screens/Login.dart';
import 'Screens/dashboard.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserActivityModel>(
      create: (BuildContext context) => UserActivityModel(),
    ),
  ],child:MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool isAuthenticated=false;
   Helper helper=Helper();


  @override
  void initState() {
    helper.fetchTokenFromLocale().then((value) =>
    {
      if(value){
        isAuthenticated=value
      }
      else{
        isAuthenticated=false
      }
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Exercise 2',
      theme: ThemeData(
        textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Colors.orange),
        textTheme: TextTheme(
          headline3: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            color: Colors.orange,
          ),
          button: const TextStyle(
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.orange),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => isAuthenticated?DashBoard(): Login(),
        'DashboardScreen': (context) =>  DashBoard(),
      },
    );
  }
}