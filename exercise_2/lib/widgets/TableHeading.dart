import 'package:flutter/material.dart';

class TableTags extends StatelessWidget {
  const TableTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(

            child: Align(

                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 5),
                  child: Text('Name',style:TextStyle(fontWeight: FontWeight.bold)),
                ))),
        Positioned(

            child: Align(

                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.18,top: 5),
                  child: Text('Age',style:TextStyle(fontWeight: FontWeight.bold)),
                ))),
        Positioned(

            child: Align(

                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.35,top: 5),
                  child: Text('Designation',style:TextStyle(fontWeight: FontWeight.bold)),
                ))),
        Positioned(

            child: Align(

                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.19,top: 5),
                  child: Text('Salary',style:TextStyle(fontWeight: FontWeight.bold)),
                )))
      ],

    );
  }
}
