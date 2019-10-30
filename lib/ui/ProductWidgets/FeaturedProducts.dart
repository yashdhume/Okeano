import 'package:flutter/material.dart';
import 'package:okeano/ui/ProductWidgets/ProductInfoPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/ViewModel.dart';

// ignore: must_be_immutable
class FeaturedProducts extends StatelessWidget {
  FeaturedProducts({this.snapshot});

  AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    var document = snapshot.data.documents;
    return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => Container(
            child: Container(
                height: 400,
                child: Center(
                  child: Swiper(
                    viewportFraction: 0.5,
                    scale: 0.5,
                    itemWidth: 300.0,
                    itemHeight: 400.0,
                    layout: SwiperLayout.DEFAULT,
                    fade: 0.0,
                    autoplay: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute<Null>(
                                        builder: (BuildContext context) {
                                  return ProductInfoPage(
                                    image: document[index]['image'],
                                    name: document[index]['name'],
                                    store: document[index]['store'],
                                    description: document[index]['description'],
                                    price: document[index]['price'],
                                    url: document[index]['url'],
                                    index: index,
                                    which: 0,
                                  );
                                }));
                              },
                              child: Hero(
                                  tag: "0 product $index",
                                  child: Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                document[index]['image']),
                                            fit: BoxFit.cover)),
                                  ))),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0))),
                              child: ListTile(
                                title: Text(document[index]['name']),
                                subtitle: Text(document[index]['price']),
                              ))
                        ],
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                  ),
                ))));
  }
}
