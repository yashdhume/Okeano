import 'package:flutter/material.dart';
import 'package:okeano/ViewModel.dart';
import 'package:okeano/data/Parser.dart';
import 'package:okeano/ui/ProductWidgets/ProductInfoPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/ui/Search.dart';

Widget buildList(BuildContext context) {
  return ScopedModelDescendant<ViewModel>(
      rebuildOnChange: true,
      builder: (context, child, model) => Scrollbar(
              child: RefreshIndicator(
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
               itemCount: model.data == null ? 0 : model.data.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> product = model.data[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductInfoPage(
                            image: product['image'],
                            name: product['name'],
                            price: product['price'],
                            store: product['store'],
                            description: product['description'],
                            url: product['url'],
                            index: index,
                            which: 2,
                          );
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                                tag: "2 product $index",
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 3, color: Colors.white),
                                    image: DecorationImage(
                                        image: NetworkImage(product['image']),
                                        fit: BoxFit.fill),
                                  ),
                                )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    product['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: <Widget>[Text(product['price'])],
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    children: <Widget>[Text(product['store'])],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ));
                }),
            // ignore: missing_return
            onRefresh: () {
              handleRefresh();
            },
          )));
}

/*String getLogo(var product) {
  if (logoData==Null)  return 'http://amspec.ph/products/amspec/JC12.jpg';
  for (int i = 0; i < logoData?.length; i++) {
    print(logoData.length);
    if (logoData[i]['store'] == product['store']) {
      return logoData[i]['image'];
    }
  }
  return 'http://amspec.ph/products/amspec/JC12.jpg';
  product['store'];
}
*/