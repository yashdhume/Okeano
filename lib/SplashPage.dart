import 'package:flutter/material.dart';
import 'RootPage.dart';
import 'package:http/http.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() =>  _SplashPage();
}
String killSwitch= 'false';

class _SplashPage extends State<SplashPage> {
  Future getKillSwitch() async{
    var client = Client();
    Response response = await client.get(
        'http://vincentssecretspot.tk/okeano/killswitch.txt'
    );
    var document = response.body;
    setState(() {
      killSwitch=document.toLowerCase();
    });
  }
  @override
  void initState() {
    getKillSwitch();
    print(killSwitch);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if(killSwitch=='true') return RootPage();
    return Container(color: Colors.white,child: Center(child: Image.network('https://okeanosgroup.cf/images/okeanoWordLogo.png')));
  }
}
