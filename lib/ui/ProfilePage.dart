import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
Widget formField(String label, String content){
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    ),
    style: TextStyle(
        color: Color(0xff4169E1),
        fontSize: 18),
    initialValue: content,
  );
}
class _ProfileState extends State<Profile> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                child: CircleAvatar(
                  radius: 100,

                  child: Image.network(
                     'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTpH7jSXXbe5rbih-yECBjQhEMkM-n5ux3xKc1UhWKeakqj2kTE',
                      ),
                )),
                SizedBox(height: 25),
                Text(
                  'Yash Dhume',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4169E1)),
                ),
                SizedBox(height: 75),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      formField("Email", "yashdhume@okeano.cf"),
                      SizedBox(height: 10),
                      formField("Phone Number", "0123456789"),
                      SizedBox(height: 10),
                      formField("Adress", "2000 Simcoe Street N"),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 140,
                  child: FlatButton(
                    child: Text(
                      "Log Out",
                      style: TextStyle(color:Color(0xff4169E1), fontSize: 18),
                    ),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
