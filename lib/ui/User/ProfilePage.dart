import 'package:flutter/material.dart';
import 'package:okeano/data/Authentication.dart';
import 'LoginPage.dart';
import 'package:okeano/ViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}



class _ProfileState extends State<Profile> {
  var index = 0;
  String userName ="";
  String emailId ="";
  String userUuid ="";
  void initState() {
    firebaseAuth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) {
          setState(() {
            userName = user.displayName;
            emailId = user.email;
            userUuid = user.uid;
          });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[],
              ),
              body: Center(child:SingleChildScrollView(
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
                      userName,
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
                          Text(emailId),
                          SizedBox(height: 10),
                         // Text(userUuid),
                          //SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 140,
                      child: FlatButton(
                        child: Text(
                          "Log Out",
                          style:
                              TextStyle(color: Color(0xff4169E1), fontSize: 18),
                        ),
                        onPressed: () async {
                          await AuthService().logout();

                          // Navigator.pushReplacementNamed(context, "/");

                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(name: "LoginPage"),
                                builder: (BuildContext context) => LoginPage()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
