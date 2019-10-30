import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:okeano/ui/ProductWidgets/RecommendedProducts.dart';
import 'package:okeano/ui/Widgets/SliverTabs.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/ui/ProductWidgets/FeaturedProducts.dart';
import 'package:flutter/services.dart';
import 'package:okeano/ui/Widgets/HomePageSearchBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
                                child: HomePageSearchBar()),
                          ],
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(child: SliverTabs(title: "Featured")),
                  SliverToBoxAdapter(
                    child: StreamBuilder(
                      stream:
                          Firestore.instance.collection('featured').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return FeaturedProducts(snapshot: snapshot);
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: SliverTabs(title: "Recommed for you")),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    return StreamBuilder(
                        stream: Firestore.instance
                            .collection('reccomended')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) CircularProgressIndicator();
                          return RecommendedProducts(
                              index: index, snapshot: snapshot);
                        });
                  },
                          //childCount: Future.value(Firestore.instance.collection('products').snapshots().length),
                          childCount: 8))
                ],
              ),
            )));
  }
}
