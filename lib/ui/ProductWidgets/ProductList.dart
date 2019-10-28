import 'package:flutter/material.dart';
import 'package:okeano/ui/ProductWidgets/ProductInfoPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/ViewModel.dart';

class ProductList extends StatelessWidget {
  ProductList({this.index, this.snapshot});

  AsyncSnapshot snapshot;
  int index;

  @override
  Widget build(BuildContext context) {
    var document = snapshot.data.documents;
    return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => Container(
            height: 100,
            child: Card(
                child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return ProductInfoPage(
                      image: document[index]['image'],
                      name: document[index]['name'],
                      store: document[index]['store'],
                      description: document[index]['description'],
                      price: document[index]['price'],
                      url: document[index]['url'],
                      index: index,
                      which: 1,
                    );
                  }));
                },
                child: ListTile(
                  trailing: IconButton(
                    icon: Icon(Icons.favorite),
                  ),
                  leading: Hero(
                      tag: "1 product $index",
                      child: CircleAvatar(
                        //radius: 0,
                        backgroundImage: NetworkImage(document[index]['image']),
                      )),
                  title: Text(
                    document[index]['name'],
                    softWrap: true,
                  ),
                  subtitle: Text(
                    document[index]['price'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ))));
  }
}
