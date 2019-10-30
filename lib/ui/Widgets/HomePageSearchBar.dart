import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CupertinoTextField(
        keyboardType: TextInputType.text,
        placeholder: 'Search',
        placeholderStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefix: Padding(
          padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
          child: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
      ),
    );
  }
}
