import 'package:flutter/material.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../data/Parser.dart';
import 'package:http/http.dart' as http;
import 'package:okeano/data/Product.dart';
import 'package:jsonstreamreader/jsonstreamreader.dart';
import 'dart:async';


class TestParser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  ScopedModelDescendant<ViewModel>(
          rebuildOnChange: true,
          builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text('Test'),
            ),
            body: Center(
              child: FutureBuilder<List<Product>>(
                future: fetchPost(http.Client(), model.searchQuery),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return TestParserList(json: snapshot.data);
                  } else if (snapshot.hasError) {
                    print("shit didnt work");
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        );
  }
}
class TestParserList extends StatelessWidget {
  final List<Product> json;

  TestParserList({Key key, this.json}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: json.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(children: <Widget>[
            Text(json[index].name),
            Text(json[index].url),
            //Text(json[index].store),
            Text(json[index].price)
          ],),
        );
      },
    );
  }
}
