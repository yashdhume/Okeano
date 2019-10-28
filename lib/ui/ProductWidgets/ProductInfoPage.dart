import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class ProductInfoPage extends StatelessWidget {
  const ProductInfoPage({Key key, this.image, this.index, this.which, this.name, this.price, this.store, this.description, this.url})
      : super(key: key);
  final int index;
  final int which;
  final String name;
  final String image;
  final String price;
  final String description;
  final String store;
  final String url;
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              child: Hero(
                  tag: "$which product $index",
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ))),
          SafeArea(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    textColor: Colors.black,
                    minWidth: 0,
                    height: 40,
                    onPressed: () => Navigator.pop(context),
                  ),
                ]),
              ),
              Spacer(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30.0),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  description,
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          color: Colors.grey.shade900,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              price,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(width: 20.0),
                            Spacer(),
                            RaisedButton(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {_launchURL(url);},
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                     Text(
                                      "Go to website",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
