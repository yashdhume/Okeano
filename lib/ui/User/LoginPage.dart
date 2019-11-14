import 'package:flutter/services.dart';
import 'package:okeano/Components/MessageSnack.dart';
import 'package:okeano/data/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:okeano/ui/MainPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: constant_identifier_names
enum FormType { LOGIN, REGISTER }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // state variables
  String _email, _password, _name;
  FormType _formType = FormType.LOGIN;
  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit(BuildContext context) async {
    if (validate()) {
      try {
        if (_formType == FormType.LOGIN) {
          await AuthService().loginUser(email: _email, password: _password);
        } else {
          await AuthService().createUser(

              email: _email,
              name: _name,
              password: _password);
        }
        setState(() {
          _loading = false;
        });

        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              settings: RouteSettings(name: "MainPage"),
              builder: (BuildContext context) => MainPage()),
        );
      } catch (e) {
        MessageSnack().showErrorMessage(
            e,
            _scaffoldKey,
                () => {
              setState(() {
                _loading = false;
              })
            });
      } finally {}
    }
  }

  void switchFormState(String state) {
    formKey.currentState.reset();

    if (state == 'register') {
      setState(() {
        _formType = FormType.REGISTER;
      });
    } else {
      setState(() {
        _formType = FormType.LOGIN;
      });
    }
  }

  Widget _logo() {
    return Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
        child: Align(
            //alignment: Alignment.bottomRight,
            child: Image.network(
                'https://scontent.fykz1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/74667362_2354525834673690_3024004924569550848_n.png?_nc_cat=103&_nc_oc=AQmQnltoRS-ooHbz4tlvDnhXRYKJuNgFaDEpUfd76W4xaJhZZ-pvrgtLntCOIf68FecX3cNwjjjErl-AmzKqiPhk&_nc_ht=scontent.fykz1-1.fna&oh=04637bd2fbc2c8c080cb308007b01cc4&oe=5E427E74')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: ModalProgressHUD(
              child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(3, 0),
                      colors: [
                        const Color(0xffb003C71),
                        const Color(0xffb0077CA),
                      ],
                    )),
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        _logo(),
                        Column(
                          children: buildInputs(_formType) +
                              [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child:
                                        Column(children: buildButtons(context)))
                              ],
                        )
                      ]),
                    )),
              ),
              inAsyncCall: _loading)),
    );
  }
  void changeValue(String value){
    setState(() {
      print(value);
      _email=value;
    });
  }
  Widget _emailInput(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey),
              ),

              onSaved: (value) =>_email = value,
            ),
          )
        ],
      ),
    );

  }
  Widget _nameInput(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.grey),
              ),

              onSaved: (value) =>_name = value,
            ),
          )
        ],
      ),
    );

  }

  bool _toggleObscureText = true;

  Widget _passwordInput() {
    return  Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
           Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              Icons.lock_open,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: _toggleObscureText,
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_toggleObscureText == true) {
                        _toggleObscureText = false;
                      } else {
                        _toggleObscureText = true;
                      }
                    });
                  },
                  child: Icon(
                    FontAwesomeIcons.eye,
                    size: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              onSaved: (value) => _password = value,
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildInputs(FormType formType) {
    var base = <Widget>[
      _emailInput(),
     _passwordInput()
    ];

    if (formType == FormType.REGISTER) {
      return base +
          <Widget>[
            _nameInput()
          ];
    } else {
      return base;
    }
  }

  Widget _submitButton(String text, String key, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              key: Key(key),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.white,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              onPressed: () => submit(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stateSwitchButton(String text, String key, String stateSwitch) {
    return Container(
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              key: Key(key),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: Colors.white,
              child: Container(
                //padding: const EdgeInsets.only(left: 20.0),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              onPressed: () => switchFormState(stateSwitch),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildButtons(BuildContext context) {
    if (_formType == FormType.LOGIN) {
      return [
        _submitButton("Login", 'login', context),
        _stateSwitchButton("Register Account", 'goto-register', 'register'),
      ];
    } else {
      return [
        _submitButton("Create Account", 'create-account', context),
        _stateSwitchButton("Back", 'go-back', 'login'),
      ];
    }
  }
}

