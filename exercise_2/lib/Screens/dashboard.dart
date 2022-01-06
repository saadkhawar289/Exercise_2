import 'package:exercise_2/Models/User.dart';
import 'package:exercise_2/Providers/User.dart';
import 'package:exercise_2/widgets/TableHeading.dart';
import 'package:exercise_2/widgets/tableTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool toggleState = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController designation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var length = context.read<UserActivityModel>().allUsers;
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            title: Text('Dashboard'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        toggleState = toggleState ? false : true;
                      });
                    },
                    child: toggleState
                        ? Icon(
                            Icons.toggle_off,
                            size: 30,
                          )
                        : Icon(
                            Icons.toggle_on,
                            size: 30,
                          )),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Employee Info'),
                    content: Container(
                      height: 250,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                labelText: "Name",
                              ),
                            ),
                            TextFormField(
                                controller: age,
                                decoration: InputDecoration(
                                  labelText: "Age",
                                )),
                            TextFormField(
                                controller: salary,
                                decoration: InputDecoration(
                                  labelText: "Salary",
                                )),
                            TextFormField(
                                controller: designation,
                                decoration: InputDecoration(
                                  labelText: "Designation",
                                )),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            User usr = User(name.text, designation.text,
                                salary.text, age.text);

                            context.read<UserActivityModel>().addEmployee(usr);
                            Navigator.of(context).pop();
                            setState(() {
                              name.clear();
                              age.clear();
                              salary.clear();
                              designation.clear();
                            });
                          },
                          child: Text('Add Employee'))
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
          body: length.isEmpty
              ? Center(child: Text('No Employee Added Yet!'))
              : toggleState
                  ? Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        addAutomaticKeepAlives: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 26,
                                  backgroundImage: NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
                                ),
                                title: Text(
                                    '${length[index].name.toString()} (${length[index].designation.toString()})',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Salary:${length[index].salary.toString()}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            'Age:${length[index].age.toString()}',
                                            style: TextStyle(fontSize: 16))
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Container(
                                  width: 69,
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Employee Info'),
                                                  content: Container(
                                                    height: 250,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller: name,
                                                            decoration: InputDecoration(
                                                                hintText: context
                                                                    .read<
                                                                        UserActivityModel>()
                                                                    .allUsers[
                                                                        index]
                                                                    .name
                                                                // labelText: "Name",
                                                                ),
                                                          ),
                                                          TextFormField(
                                                              controller: age,
                                                              decoration: InputDecoration(
                                                                  hintText: context
                                                                      .read<
                                                                          UserActivityModel>()
                                                                      .allUsers[
                                                                          index]
                                                                      .age)),
                                                          TextFormField(
                                                              controller:
                                                                  salary,
                                                              decoration: InputDecoration(
                                                                  hintText: context
                                                                      .read<
                                                                          UserActivityModel>()
                                                                      .allUsers[
                                                                          index]
                                                                      .salary)),
                                                          TextFormField(
                                                              controller:
                                                                  designation,
                                                              decoration: InputDecoration(
                                                                  hintText: context
                                                                      .read<
                                                                          UserActivityModel>()
                                                                      .allUsers[
                                                                          index]
                                                                      .designation)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    UserActivityModel>()
                                                                .allUsers[index]
                                                                .name = name
                                                                    .text
                                                                    .isEmpty
                                                                ? context
                                                                    .read<
                                                                        UserActivityModel>()
                                                                    .allUsers[
                                                                        index]
                                                                    .name
                                                                : name.text;

                                                            context
                                                                .read<
                                                                    UserActivityModel>()
                                                                .allUsers[index]
                                                                .salary = salary
                                                                    .text
                                                                    .isEmpty
                                                                ? context
                                                                    .read<
                                                                        UserActivityModel>()
                                                                    .allUsers[
                                                                        index]
                                                                    .salary
                                                                : salary.text;

                                                            context
                                                                .read<
                                                                    UserActivityModel>()
                                                                .allUsers[index]
                                                                .age = age.text
                                                                    .isEmpty
                                                                ? context
                                                                    .read<
                                                                        UserActivityModel>()
                                                                    .allUsers[
                                                                        index]
                                                                    .age
                                                                : age.text;

                                                            context
                                                                .read<
                                                                    UserActivityModel>()
                                                                .allUsers[index]
                                                                .designation = designation
                                                                    .text
                                                                    .isEmpty
                                                                ? context
                                                                    .read<
                                                                        UserActivityModel>()
                                                                    .allUsers[
                                                                        index]
                                                                    .designation
                                                                : designation
                                                                    .text;

                                                            name.clear();
                                                            age.clear();
                                                            salary.clear();
                                                            designation.clear();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        },
                                                        child: Text('Done'))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<UserActivityModel>()
                                                  .delEmployee(index);
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 2,
                                thickness: 2,
                              )
                            ],
                          );
                        },
                        itemCount:
                            context.read<UserActivityModel>().allUsers.length,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.black,
                          ),
                          color: Colors.white54,
                        ),
                        child: Column(
                          children: [
                            TableTags(),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                addAutomaticKeepAlives: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: TableTile(
                                              context
                                                  .read<UserActivityModel>()
                                                  .allUsers[index],
                                              index),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              hoverColor: Colors.green,
                                              splashRadius: 30,
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  context
                                                      .read<UserActivityModel>()
                                                      .delEmployee(index);
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: context
                                    .read<UserActivityModel>()
                                    .allUsers
                                    .length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        )));
  }
}
