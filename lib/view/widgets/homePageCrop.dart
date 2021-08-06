import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:managents/data/Firebase/IrrPrescGet.dart';
import 'package:managents/util/colors.dart';
import 'package:managents/view/CreateNewCrop.dart';
import 'package:managents/view/UserProfilePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:managents/view/ViewHourIrrig/homepageIrrigation.dart';
import 'package:managents/view/ViewHourIrrig/homepagePrescription.dart';
import 'package:managents/view/viewSensorsCrop.dart';

class HomePageCrop extends StatefulWidget {
  @override
  _HomePageCropState createState() => _HomePageCropState();
}

class _HomePageCropState extends State<HomePageCrop> {
  List<String> cropsAgents = ['Tibasosa_1', 'Tibasosa_2', 'Tibasosa_3'];
  String actualCrop;

  @override
  void initState() {
    print('alldocuments');
    loadinfoDataFireBase();
    super.initState();
  }

  void loadinfoDataFireBase() {
    GetFirebaseIrrPresc().ConsultColllctions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: colorAzulApp,
            ),
            child: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: DrawerHeader(
                        child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(color: Colors.white10),
                        ),
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 10,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage('assets/img/AP.png'),
                                fit: BoxFit.contain,
                              )),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                      elevation: 2,
                                      color: colorAppBar,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pop(Duration(seconds: 2));
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          CreateNewCrop()));
                                        },
                                        leading: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        title: Text(
                                          'ADD AGENT',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                            fontSize: 20,
                                          ),
                                        ),
                                        dense: true,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cropsAgents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Card(
                              elevation: 2,
                              color: colorAppBar,
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  print('Card tapped.');
                                  Navigator.of(context)
                                      .pop(Duration(seconds: 2));
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.seedling,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 10),
                                      child: Text(
                                        cropsAgents[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenSans',
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                  Card(
                      elevation: 2,
                      color: colorAppBar,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pop(Duration(seconds: 2));
                        },
                        leading: Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 25,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'LOG OUT',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        dense: true,
                      )),
                ],
              ),
            )),
        body: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1 / 4,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 25,
                    left: 30,
                    right: 30.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [colorAzulApp, Color(0xff4e80f3)]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: _upperContainer(),
              ),
              _agentsNames(),
              Container(
                  alignment: Alignment.topCenter,
                  //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  height: MediaQuery.of(context).size.height * (5 / 8),
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      _buildSingleCArd(
                        'Irrigation',
                        0,
                        FontAwesomeIcons.water,
                        '3.0 mm',
                      ),
                      _buildSingleCArd(
                        'Sensors',
                        1,
                        FontAwesomeIcons.thermometer,
                        '3.0 mm',
                      ),
                      _buildSingleCArd(
                        'Prescription',
                        2,
                        FontAwesomeIcons.eyeDropper,
                        '3.0 mm',
                      ),
                      _buildSingleCArd(
                        'Crop',
                        3,
                        FontAwesomeIcons.seedling,
                        '3.0 mm',
                      )
                    ],
                  )),
            ]),
            Positioned(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )),
          ],
        ),
      ),
    );
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
                    style: TextStyle(color: Colors.white, fontSize: 15),
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
                  print("user page ");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UserProfilePage()));
                },
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                width: 40,
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
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        width: 10,
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
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Text(
              'Tibasosa 1',
              style: TextStyle(
                  color: Color(0xff4e80f3),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleCArd(
      String name, int index, IconData iconcard, String subtittle) {
    return new InkWell(
      onTap: () {
        print("ok...");
        setState(() {
          print('go');
          if (name == 'Irrigation') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomePageIrrPresc()));
          } else if (name == 'Prescription') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomePagePrescription()));
          } else if (name == 'Sensors') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ViewSensorsCrop()));
          }
        });
      },
      child: Ink(
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
                  colors: [colorAzulApp, Color(0xff4e80f3)]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(iconcard, color: Colors.lightBlue),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  subtittle,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              // Icon(model.allYatch[index].topRightIcon,color:model.allYatch[index].isEnable ? Colors.white : Color(0xffa3a3a3))
            ],
          ),
        ),
      ),
    );
  }
}
