import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okeano/ui/ProductWidgets/ProductList.dart';
import 'package:okeano/ui/ProductWidgets/SubTitle.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/ui/ProductWidgets/StackableSwiper.dart';
import 'package:flutter/services.dart';
import 'package:okeano/data/Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var location = 0.0;
  bool a = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 150.0,
                    pinned: true,
                    floating: true,
                    snap: true,
                    flexibleSpace: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      location = constraints.biggest.height;

                      if (constraints.biggest.height == 100.0) {
                        a = true;
                      } else {
                        a = false;
                      }

                      return FlexibleSpaceBar(
                        centerTitle: true,
                        title: Image.network(
                          "https://scontent-yyz1-1.xx.fbcdn.net/v/t1.15752-9/73321638_1322612184612597_3813862690342830080_n.png?_nc_cat=106&_nc_oc=AQmCS13b4ccKhKXg5DhfseJGDnC1C5_R-3WVx-emBgzGy_UpSUXK_4b04WkL0is7vuU&_nc_ht=scontent-yyz1-1.xx&oh=8ba36fe62a88618232eb1f30160b3b95&oe=5E1A1D23",
                          scale: 10,
                        ),
                        background: Column(
                          children: <Widget>[
                            SizedBox(height: 60.0),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 6.0, 16.0, 16.0),
                              child: Container(
                                width: double.infinity,
                                child: CupertinoTextField(
                                  keyboardType: TextInputType.text,
                                  placeholder: 'Search',
                                  placeholderStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                  prefix: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        9.0, 6.0, 9.0, 6.0),
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
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(child: SubTitle(title: "Featured")),
                  SliverToBoxAdapter(
                      child:  StackableSwiper()),
                  SliverToBoxAdapter(
                      child: SubTitle(title: "Recommed for you")),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ProductList(index: index);
                    },
                    childCount: model.urls.length,
                  ))
                ],
              ),
            )));
  }
}
