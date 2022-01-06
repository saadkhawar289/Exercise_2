import 'package:exercise_2/Models/User.dart';
import 'package:flutter/material.dart';

class TableTile extends StatelessWidget {
  final User user;
  final int index;

  const TableTile(this.user, this.index);

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        user.name!,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildAge() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          user.age!.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ));
  }

  Widget _buildSalary() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        user.salary.toString(),
        style: TextStyle(
          // fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.green,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    final double targetWidth =
        deviceWidth > 550.0 ? deviceWidth * 0.65 : deviceWidth * 0.97;
    final double targetHeight =
        deviceHeight > 550.0 ? deviceHeight * 0.50 : deviceHeight * 0.10;
    return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Container(
                  width: deviceWidth < 600
                      ? targetWidth * 0.75
                      : targetWidth * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(flex: 2, child: _buildName()),
                          Expanded(flex: 2, child: _buildAge()),
                          Expanded(
                              flex: 3,
                              child: Text(
                                '${user.designation.toString()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              )),
                          Expanded(flex: 2, child: _buildSalary())
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        height: 2,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
