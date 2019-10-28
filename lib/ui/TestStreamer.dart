import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class SHIT extends StatefulWidget {
  @override
  _SHIT createState() => new _SHIT();
}

class _SHIT extends State<SHIT> {
  Timer timer;
  int counter = 0;


  void addValue() {
    setState(() {
      counter++;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  StreamController _postsController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;

  Future fetchPost([howMany = 5]) async {
    String product = "tims";
    final response = await http.get(
        'http://vincentssecretspot.tk/okeano/products/'+product+'.json');

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

  Future<Null> _handleRefresh() async {
    count++;
    print(count);

      fetchPost(count * 5).then((res) async {
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
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      appBar:  AppBar(
        title: Text('StreamBuilder'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: Icon(Icons.refresh),
            onPressed: _handleRefresh,
          )
        ],
      ),
      body: StreamBuilder(
        stream: _postsController.stream,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
         // print('Has error: ${snapshot.hasError}');
         // print('Has data: ${snapshot.hasData}');
          //print('Snapshot Data ${snapshot.data}');
          reassemble();
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }

          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var post = snapshot.data[index];
                          return ListTile(
                            title: Text(post['name']),
                            subtitle: Text(post['store']),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('No Posts');
          }
        },
      ),
    );
  }
}