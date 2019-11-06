import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ViewModel.dart';
import 'SplashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
          home: SplashPage(),
        ));
  }
}
