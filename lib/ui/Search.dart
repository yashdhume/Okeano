import 'package:flutter/material.dart';
import '../ViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
//import 'package:okeano/data/Parser.dart';
import 'package:okeano/ui/Widgets/BuildSearchProductList.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
final myController = TextEditingController();
StreamController postsController;
String searchQuery;

SocketIOManager manager;
Map<String, SocketIO> sockets = {};
Map<String, bool> _isProbablyConnected = {};
bool isOn=false;
SocketIO socket;
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
  initSocket(String identifier) async {
    ViewModel model = ScopedModel.of(this.context);

    setState(() => _isProbablyConnected[identifier] = true);
    socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
      "http://okeano.herokuapp.com",
    ));
    socket.onConnect((data) {
      print("connected...");
      socket.emit("search", ["chair"]);
      print(data);
    });
    socket.on("product", (curData){
      pprint(curData, model);
    });
    /*socket.on("resultType", (data){
      pprint(data, model);
    })*/;
    socket.connect();
    sockets[identifier] = socket;
  }
  bool isProbablyConnected(String identifier){
    return _isProbablyConnected[identifier]??false;
  }
  pprint(data, model) {
   setState(() {
    //  print("Model: " + data.toString());
      model.addData(data);
      //model.data.add(data);
   });
  }
  disconnect(String identifier) async {
    await manager.clearInstance(sockets[identifier]);
    setState(() => _isProbablyConnected[identifier] = false);
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
   // getData();

    manager = SocketIOManager();
    initSocket("default");
    postsController = StreamController();
    //timer = Timer.periodic(Duration(seconds: 1), (Timer t) => handleRefresh());

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
                        child: model.data.length!=null ? buildList(context) : CircularProgressIndicator()

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
                                 //     model.updateSearchQuery(myController);
                                      print(10);
                                  //    searchQuery = model.searchQuery;
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
