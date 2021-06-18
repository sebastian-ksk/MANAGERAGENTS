import 'package:flutter/material.dart';
import 'package:managents/util/colors.dart';

//dialogos emergentes y paginas de carga
class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }

  static Future<void> dialogBox(
    BuildContext context,
    String menssage,
    GlobalKey key,
  ) {
    return showDialog(
      context: context,
      builder: (builder) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context, rootNavigator: true).maybePop(true);
          //maybePop soluciona panatalla negra ocacional que aparecia cada vez que
          //se hacia onBack cuando se mostravba cuadro de texto
        });

        return AlertDialog(
          backgroundColor: colorAzulApp,
          title: Center(
            child: Text(
              menssage,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}
