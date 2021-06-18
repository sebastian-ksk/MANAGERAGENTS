import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:managents/models/Scopedmodels/PropCropVariables.dart';
import 'package:managents/view/UserProfilePage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageCrop extends StatefulWidget {
  @override
  _HomePageCropState createState() => _HomePageCropState();
}

class _HomePageCropState extends State<HomePageCrop> {
  final PropCropVariables model = PropCropVariables();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: model,
        child: Scaffold(
          body: Column(children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  bottom: 30,
                  left: 30,
                  right: 30.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff669df4), Color(0xff4e80f3)]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: _upperContainer(),
            ),
            _agentsNames(),
            _applianceGrid(model)
          ]),
        ));
  }

  Widget _upperContainer() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'July 16 2021',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'Hello Sebastian!',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/img/AP.png'),
                  radius: 30,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UserProfilePage()));
                },
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(25)),
                child: Icon(
                  FontAwesomeIcons.tint,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '1.0',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Lts',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Text(
                    'Irrigation applied today',
                    style: TextStyle(color: Colors.white54, fontSize: 18),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _agentsNames() {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Text(
              'Tibasosa 1',
              style: TextStyle(
                  color: Color(0xff4e80f3),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roomLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xffb2b0b9),
        fontSize: 18,
      ),
    );
  }

  Widget _buildApplianceCard(PropCropVariables model, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          model.allYatch[index].isEnable = !model.allYatch[index].isEnable;
        });
      },
      child: Container(
        height: 100,
        margin: index % 2 == 0
            ? EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
            : EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0, 10),
                  color: Color(0xfff1f0f2))
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: model.allYatch[index].isEnable
                    ? [Color(0xff669df4), Color(0xff4e80f3)]
                    : [Colors.white, Colors.white]),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(model.allYatch[index].leftIcon,
                    color: model.allYatch[index].isEnable
                        ? Colors.white
                        : Color(0xffa3a3a3)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                model.allYatch[index].title,
                style: TextStyle(
                    color: model.allYatch[index].isEnable
                        ? Colors.white
                        : Color(0xff302e45),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                model.allYatch[index].subtitle,
                style: TextStyle(
                    color: model.allYatch[index].isEnable
                        ? Colors.white
                        : Color(0xffa3a3a3),
                    fontSize: 20),
              ),
            ),
            // Icon(model.allYatch[index].topRightIcon,color:model.allYatch[index].isEnable ? Colors.white : Color(0xffa3a3a3))
          ],
        ),
      ),
    );
  }

  Widget _applianceGrid(PropCropVariables model) {
    return Container(
        alignment: Alignment.topCenter,
        //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        height: 400,
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(0),
          children: List.generate(model.allYatch.length, (index) {
            return model.allYatch[index].title != null
                ? _buildApplianceCard(model, index)
                : Container();
          }),
        ));
  }
}
