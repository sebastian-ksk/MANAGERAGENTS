import 'package:flutter/material.dart';
import 'package:managents/util/colors.dart';
import 'package:managents/util/customViews.dart';
import 'package:managents/view/widgets/dialogs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool eyePass = false;
  bool logButton = false;
  bool logincharge = false;
  //controladores de Texto para usuario y pasword
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  TextEditingController _textEditingControllerPasword =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Row(
          children: [
            SizedBox(width: 5.0),
            Container(
              width: _width / 4,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/img/uptc.png'),
              )),
            ),
            SizedBox(width: 15.0),
            Center(
              child: Column(
                children: [
                  Container(
                      height: 25,
                      child: Text("Real Agents",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                          ))),
                  Container(
                      height: 25,
                      child: Text("Manager",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                          ))),
                ],
              ),
            ),
            SizedBox(width: 18.0),
            Container(
              width: _width / 4,
              height: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/img/dsplogo.png'),
              )),
            ),
          ],
        ),
      ),
      body: logincharge //flag LogIn
          ? _buildAnimationCharge(context) //carga de pantalla d animacion LogIn
          : _buildLoginbody(context), //pantalla principal de LogIn
    );
  }

  //============================pantalla principal de Log In====================
  Widget _buildLoginbody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 344,
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
          //===================DECORACION DEL CONTENEDOR ===================
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                //sombreado
                BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black12)
              ]),
          //================================================================
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 25,
                ),
                width: 344,
                height: (MediaQuery.of(context).size.height / 1.80) / 5,
                color: colorAzulApp,
                child: Text(
                  "iniciar Sesión",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              _buildUserName(),
              SizedBox(height: 5.0),
              _buildPasword(),
              SizedBox(height: 20.0),
              _buildLoginBtn(context),
            ],
          ),
        ),
        Container(
          width: 344,
          margin: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('assets/img/AP.png')),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  //CAMPO PARA INGRESO DE USERNAME
  Widget _buildUserName() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 80.0,
      child: TextField(
        controller: _textEditingControllerEmail,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            FontAwesomeIcons.userAlt,
            color: Colors.black,
            size: 22,
          ),
          hintText: 'Usuario o Email .',
          hintStyle: formsTextStyle,
        ),
      ),
    );
  }

  //CAMPO PARA INGRESO DE CONTASEÑA
  Widget _buildPasword() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 80.0,
      child: TextField(
        controller: _textEditingControllerPasword,
        obscureText: eyePass == false ? true : false,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            FontAwesomeIcons.lock,
            color: Colors.black,
            size: 22,
          ),
          suffixIcon: IconButton(
            icon: Icon(eyePass == false
                ? FontAwesomeIcons.solidEye
                : FontAwesomeIcons.eyeSlash),
            onPressed: () {
              setState(() {
                eyePass = !eyePass;
              });
            },
          ),
          hintText: 'Contaseña',
          hintStyle: formsTextStyle,
        ),
      ),
    );
  }

  //BOTON DE INICIO DE SESION
  Widget _buildLoginBtn(BuildContext context) {
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: 240,
      height: 70,

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
            // try {
            //   bool user = await getLogin(
            //       context: context,
            //       username: _textEditingControllerEmail.text,
            //       pasword: _textEditingControllerPasword.text);
            //   if (user) {
            //     // _userProv.userEnabled = user;
            //     Navigator.of(context).pushAndRemoveUntil(
            //       MaterialPageRoute(
            //           builder: (BuildContext context) => PrincipalPage()),
            //       (Route<dynamic> route) => false,
            //     );
            //     //setState(() => logincharge = false);
            //   } else {
            //     setState(() => logincharge = false);
            //     print("eror de contraseña");
            //     //retorno de showdialog con indicacion de contraseña incorrecta
            //     return Dialogs.dialogBox(
            //         context, "Usuario o Contaseña incorrecta", _keyLoader);
            //   }
            // } catch (e) {
            //   setState(() => logincharge = false);
            // }
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: colorAzulApp,
        child: Text(
          'INICIAR SESIÓN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 25,
          ),
        ),
      ),
    );
  }

//=======================pagina de animada de carga de pagina ================
  _buildAnimationCharge(BuildContext context) => Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: 200,
          height: 200,
          child: Column(
            children: <Widget>[
              Swing(
                duration: Duration(seconds: 5),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/siot_logo.png')),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
