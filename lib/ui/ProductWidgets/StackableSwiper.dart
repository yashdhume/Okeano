import 'package:flutter/material.dart';
import 'package:okeano/ui/ProductInfoPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/ViewModel.dart';

class StackableSwiper extends StatelessWidget {
  StackableSwiper();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => Container(
                child: Container(
              height: 340,
              child: Swiper(
                pagination: new SwiperPagination(),
                viewportFraction: 0.5,
                scale: 0.5,
                itemWidth: 300.0,
                itemHeight: 400.0,
                layout: SwiperLayout.DEFAULT,
                fade: 0.0,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                              return ProductInfoPage(
                                image: model.urls[index],
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
                                        image: NetworkImage(model.urls[index]),
                                        fit: BoxFit.cover)),
                              ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))),
                          child: ListTile(
                            subtitle: Text("Somthing"),
                            title: Text("Somthing else"),
                          ))
                    ],
                  );
                },
                itemCount: model.urls.length,
              ),
            )));
  }
}
