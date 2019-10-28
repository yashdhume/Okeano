import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CupertinoTextField(
        keyboardType: TextInputType.text,
        placeholder: 'Search',
        placeholderStyle: TextStyle(
          color: Color(0xffC4C6CC),
          fontSize: 14.0,
        ),
        prefix: Padding(
          padding:
          const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
          child: Icon(
            Icons.search,
            color: Color(0xffC4C6CC),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xffF0F1F5),
        ),
      ),
    );
  }
}
