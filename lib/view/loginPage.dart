import 'package:flutter/material.dart';
import 'package:managents/data/Firebase/ApiServiceAuth.dart';
import 'package:managents/util/colors.dart';
import 'package:managents/util/constans/theme_data.dart';
import 'package:managents/util/customViews.dart';
import 'package:managents/view/widgets/dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:managents/view/widgets/homePageCrop.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool eyePass = false;
  bool logButton = false;
  bool logincharge = false;
  bool _rememberMe = false;
  //controladores de Texto para usuario y pasword
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  TextEditingController _textEditingControllerPasword =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/Campo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height * (3 / 4),
            margin: EdgeInsets.only(top: 10, left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: colorAzulApp.withOpacity(0.4))
              ],
              color: Colors.transparent,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: colorAzulApp,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img/AP.png'))),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            child: Text(
                              'MANAGER AGENTS',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img/dsplogo.png'))),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                _buildUserName(),
                SizedBox(height: 5.0),
                _buildPasword(),
                SizedBox(height: 5.0),
                _buildLoginBtn(context),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      _buildRememberMeCheckBox(),
                      InkWell(
                        onTap: () {
                          print('I forget my paswword !!');
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'Forget Pasword?',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildRememberMeCheckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember Me ',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  //BOTON DE INICIO DE SESION
  Widget _buildLoginBtn(BuildContext context) {
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();
    final _loginState = Provider.of<Authentication>(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
      child: Container(
        width: 250,
        height: 50,
        child: Opacity(
          opacity: 0.8,
          // ignore: deprecated_member_use
          child: RaisedButton(
            elevation: 5.0,
            onPressed: () async {
              print('Login Botton pressed');

              logButton = !logButton;
              if (_textEditingControllerEmail.text.isEmpty ||
                  _textEditingControllerPasword.text.isEmpty) {
                logButton = !logButton;
                print('contraseña o email vacio');
                return Dialogs.dialogBox(
                    context, "Error! Campo de Login Vacio", _keyLoader);
              } else {
                logButton = !logButton;
                setState(() => logincharge = true);
                try {
                  User userLogin = await Authentication().Login(
                      username: _textEditingControllerEmail.text,
                      password: _textEditingControllerPasword.text);
                  print('verificado usuario? ');
                  print(!_loginState.isLoading);

                  if (userLogin.email.isNotEmpty) {
                    print(!_loginState.isLoading);
                    // _userProv.userEnabled = user;
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePageCrop()),
                      (Route<dynamic> route) => false,
                    );
                    setState(() => logincharge = false);
                  } else {
                    setState(() => logincharge = false);
                    print("error de contraseña");
                    //retorno de showdialog con indicacion de contraseña incorrecta
                    return Dialogs.dialogBox(
                        context, "Usuario o Contaseña incorrecta", _keyLoader);
                  }
                } catch (e) {
                  setState(() => logincharge = false);
                }
              }
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: colorAzulApp,
            child: Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

//CAMPO PARA INGRESO DE CONTASEÑA
  Widget _buildPasword() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: TextField(
        controller: _textEditingControllerPasword,
        obscureText: eyePass == false ? true : false,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'avenir',
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            FontAwesomeIcons.lock,
            color: Colors.white12,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              eyePass == false
                  ? FontAwesomeIcons.solidEye
                  : FontAwesomeIcons.eyeSlash,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                eyePass = !eyePass;
              });
            },
          ),
          hintText: 'Contaseña',
          labelStyle: TextStyle(fontSize: 20),
          hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              fontSize: 15),
        ),
      ),
    );
  }

//CAMPO PARA INGRESO DE USERNAME
  Widget _buildUserName() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: TextField(
        controller: _textEditingControllerEmail,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'avenir',
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey, width: 2)),
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            FontAwesomeIcons.userAlt,
            color: Colors.white12,
            size: 20,
          ),
          hintText: 'User Email ',
          labelStyle: TextStyle(fontSize: 20),
          hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'avenir',
              fontWeight: FontWeight.w700,
              fontSize: 15),
        ),
      ),
    );
  }

  Widget _textToInfo(String message) {
    return Text(
      message,
      style: TextStyle(
          fontFamily: 'avenir',
          fontWeight: FontWeight.w700,
          color: CustomColors.primaryTextColor,
          fontSize: 25),
    );
  }
}
