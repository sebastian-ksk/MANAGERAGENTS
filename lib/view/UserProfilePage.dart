import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Color(0xffe7eaf2),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(40.0, 40, 40, 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Manager Agents',
                style: TextStyle(fontSize: 43, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        offset: Offset(10, 15),
                        color: Color(0x22000000),
                        blurRadius: 20.0)
                  ],
                  image:
                      DecorationImage(image: AssetImage('assets/img/AP.png'))),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Sebastian Castellanos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70,
            ),
            _placeContainer('Tibasosa 1', Color(0xff526fff), false),
            _placeContainer('Add another one', Color(0xffffffff), true),
          ],
        ),
      ),
    ));
  }

  Widget _placeContainer(String title, Color color, bool leftIcon) {
    return Column(
      children: <Widget>[
        Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 40,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: color),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: leftIcon ? Color(0xffa3a3a3) : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                leftIcon
                    ? Icon(
                        Icons.add,
                        color: Color(0xffa3a3a3),
                      )
                    : Container()
              ],
            ))
      ],
    );
  }
}
