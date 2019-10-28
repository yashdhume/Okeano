import 'package:flutter/material.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:okeano/data/Product.dart';
import '../data/Parser.dart';
import 'package:http/http.dart' as http;
import 'package:okeano/ui/ProductInfoPage.dart';
import 'dart:async';
import 'dart:convert';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  _Search createState() => _Search();
}

class _Search extends State<Search> {
  final _myController = TextEditingController();
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  String searchQuery;
  bool isOn=false;

  final primary = Color(0xff4169E1);
  final secondary = Colors.white;
  Timer timer;
  int counter = 0;

  @override
  void dispose() {
    _myController.dispose();
    timer?.cancel();
    super.dispose();
  }

  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  Future fetchPost([howMany = 5]) async {
    final response = await http.get(
        'http://vincentssecretspot.tk/okeano/products/' +
            searchQuery +
            '.json');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  loadPosts() async {
    fetchPost().then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }
  Widget _indicator (){
    if(isOn){
      return CircularProgressIndicator();
    }
    else
      return Text('');
  }
  Future<Null> _handleRefresh() async {
    count++;
    print(count);

    fetchPost(searchQuery).then((res) async {
      print(count);
      _postsController.add(res);
      showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _postsController = new StreamController();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _handleRefresh());
    //loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ViewModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => Scaffold(
              backgroundColor: Color(0xfff0f0f0),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 145),
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: StreamBuilder(
                          stream: _postsController.stream,
                          builder:
                              // ignore: missing_return
                              (BuildContext context, AsyncSnapshot snapshot) {
                            reassemble();
                            if (snapshot.hasError) {
                              return Text(snapshot.error);
                            }
                            if (snapshot.hasData) {
                              //print(snapshot.data);
                              return buildList(snapshot, context);
                            }
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Center(
                                child: _indicator(),
                              );
                            }

                            if (!snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return Text('No Posts');
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 110,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Material(
                                elevation: 5.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: TextField(
                                  controller: _myController,
                                  textInputAction: TextInputAction.go,
                                  onSubmitted: (_myController) {
                                    setState(() {
                                      model.updateSearchQuery(_myController);
                                      print(10);
                                      searchQuery = model.searchQuery;
                                      isOn=true;
                                    });

                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: dropdownMenuItem,
                                  decoration: InputDecoration(
                                      hintText: "Search Product",
                                      hintStyle: TextStyle(
                                          color: Colors.black38, fontSize: 16),
                                      prefixIcon: Material(
                                        elevation: 0.0,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Icon(Icons.search),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 13)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget buildList(AsyncSnapshot snapshot, BuildContext context) {
    return Scrollbar(
        child: RefreshIndicator(
            onRefresh: () => _handleRefresh(),
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
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
                        height: 110,
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
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border:
                                        Border.all(width: 3, color: secondary),
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
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 1,
                                      ),
                                      Text(product['price'],
                                          style: TextStyle(
                                            color: primary,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(product['store'],
                                          style: TextStyle(
                                            color: primary,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                })));
  }
}
