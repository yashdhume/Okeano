import 'package:flutter/material.dart';
import 'package:okeano/ui/ProductInfoPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/ViewModel.dart';

class ProductList extends StatelessWidget {
  ProductList({this.index});

  int index;

  @override
  Widget build(BuildContext context) {
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
                      image: model.urls[index],
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
                        backgroundImage: NetworkImage(model.urls[index]),
                      )),
                  title: Text(
                    'Somthing',
                    softWrap: true,
                  ),
                  subtitle: Text(
                    '\$420.69',
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
