import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ui/MainPage.dart';
import 'ViewModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ViewModel>(
        model: ViewModel(),
        child: MaterialApp(
          title: 'Okeano',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            primaryColor: Color(0xff4169E1),
            accentColor: Colors.cyan[600],
          ),
          home: MainPage(),
        ));
  }
}
