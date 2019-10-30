import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliverTabs extends StatelessWidget {
  SliverTabs({this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xff4169E1),
            border: Border(top: BorderSide(color: Colors.grey))),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                  onPressed: () {},
                  child: Text(title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ],
          ),
        ));
  }
}
