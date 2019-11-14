import 'package:flutter/material.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:okeano/data/Parser.dart';
import 'package:okeano/ui/Widgets/BuildSearchProductList.dart';
import 'package:http/http.dart' as http;

final myController = TextEditingController();
StreamController postsController;
String searchQuery;
bool isOn = false;

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _Search createState() => _Search();
}
var logoData;

class _Search extends State<Search> {



  Future<void> getData() async {
    http.Response response = await http.get(
        "http://vincentssecretspot.tk/okeano/logos.json");
       // headers: {"Accept": "application/json"});
    setState(() {
      logoData = json.decode(response.body);
    });
  }
  Timer timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getData();
    postsController = StreamController();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => handleRefresh());
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
                          stream: postsController.stream,
                          builder:
                              // ignore: missing_return
                              (BuildContext context, AsyncSnapshot snapshot) {
                            //reassemble();
                            if (snapshot.hasError) {
                              return Text(snapshot.error);
                            }
                            if (snapshot.hasData) {
                              return buildList(snapshot, context);
                            }
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Center(
                                child: indicator(),
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
                            color: Color(0xff4169E1),
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
                                  controller: myController,
                                  textInputAction: TextInputAction.go,
                                  onSubmitted: (myController) {
                                    setState(() {
                                      model.updateSearchQuery(myController);
                                      print(10);
                                      searchQuery = model.searchQuery;
                                      isOn = true;
                                    });
                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
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
}
