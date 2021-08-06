import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:managents/data/Firebase/IrrPrescGet.dart';
import 'package:managents/util/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fl_chart/fl_chart.dart';

class ViewSensorsCrop extends StatefulWidget {
  @override
  _ViewSensorsCropState createState() => _ViewSensorsCropState();
}

class _ViewSensorsCropState extends State<ViewSensorsCrop> {
  List<String> allSensors = ['Tibasosa_1', 'Tibasosa_2', 'Tibasosa_3'];
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

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
        endDrawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: colorAzulApp,
            ),
            child: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: allSensors.length,
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
                                      child: Text(allSensors[index],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                            fontSize: 20,
                                          )),
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                ],
              ),
            )),
        body: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1 / 5,
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
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Sensor : VWC1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(top: 10, right: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 3 / 5,
                child: LineChart(
                  LineChartData(
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: dummyData1,
                          isCurved: true,
                          barWidth: 3,
                          colors: [
                            Colors.red,
                          ],
                        ),
                        LineChartBarData(
                          spots: dummyData2,
                          isCurved: true,
                          barWidth: 3,
                          colors: [
                            Colors.orange,
                          ],
                        ),
                      ]),
                ),
              ),
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
}
