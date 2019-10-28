import 'package:flutter/material.dart';
import 'package:okeano/GoogleMaps/GoogleMaps.dart';
import 'package:okeano/data/FirebaseData.dart';
import 'package:okeano/ui/Search.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'HomePage.dart';
import 'TestParser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:okeano/data/Product.dart';
import 'TestStreamer.dart';

class MainPage extends StatefulWidget {
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    Search(),
    TestParser(),
    GoogleMaps(),
    SHIT(),
  ];
  void initState(){

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: Colors.transparent,
                  color: Color(0xff4169E1),
                  initialIndex: 0,
                  items: <Widget>[
                    Icon(Icons.home, size: 30, color: Colors.white),
                    Icon(Icons.search, size: 30, color: Colors.white),
                    Icon(Icons.favorite, size: 30, color: Colors.white),
                    Icon(Icons.pin_drop, size: 30, color: Colors.white),
                    Icon(Icons.person, size: 30, color: Colors.white),
                  ],
                  onTap: (index) {
                    setState(() {
                      Product json;
                      var a = getFirebase();
                      print(a);
                      _currentIndex = index;
                    });
                  }),
              body: (_children[_currentIndex]),
            ));
  }
}
