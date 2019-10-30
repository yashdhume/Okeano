import 'package:flutter/material.dart';
import 'package:okeano/GoogleMaps/TestGoogleMaps.dart';
import 'package:okeano/ui/Search.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'HomePage.dart';

class MainPage extends StatefulWidget {
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    Search(),
    Search(),
    TGoogleMaps(),
    Search(),
  ];

  void initState() {
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
                      _currentIndex = index;
                    });
                  }),
              body: (_children[_currentIndex]),
            ));
  }
}
