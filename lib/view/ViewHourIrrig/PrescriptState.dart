import 'package:flutter/material.dart';
import 'package:managents/data/Firebase/IrrPrescGet.dart';
import 'package:managents/models/FirebaseModels/ResultPrescIrrModel.dart';
import 'package:managents/models/FirebaseModels/irrigationPrescModel.dart';
import 'package:managents/util/constans/theme_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrescriptionState extends StatefulWidget {
  @override
  _PrescriptionStateState createState() => _PrescriptionStateState();
}

class _PrescriptionStateState extends State<PrescriptionState> {
  var gradientColor = GradientTemplate.gradientTemplate[0].colors;
  String value = 'False';
  List<String> menu = ['True', 'False'];
  String valueModePresc = 'Better';
  List<String> menuTypePresc = [
    'Weather_Station',
    'Moisture_Sensors',
    'Better'
  ];
  var colorMetodPresc = 0;
  var colorNegotiation = 0;
  bool _presDone = false;
  IrrPrescModel irrPrescModel;
  ResultPrescIrrModel resultPrescIrrModel;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users =
      FirebaseFirestore.instance.collection('Tibasosa_3');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResultPrescIrrModel>(
        future: GetFirebaseIrrPresc().ConsultResultIrrPresc(),
        builder: (_, AsyncSnapshot<ResultPrescIrrModel> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            print(snapshot.data.netPrescription);
            print('Yes Has data ');
            children = <Widget>[
              Text(
                'Prescription State',
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    color: CustomColors.primaryTextColor,
                    fontSize: 24),
              ),
              Image.asset(
                _presDone
                    ? 'assets/img/dropperOn.png'
                    : 'assets/img/dropperOff.png',
                height: 100,
              ),
              _cropProperties(0, 'prescription: ',
                  snapshot.data?.netPrescription?.toString() ?? '0.0'),
              _cropProperties(
                  2,
                  'Date Prescrtiption :',
                  snapshot.data?.lastPrescriptionDate?.toString() ??
                      'No Date Found '),
              _downListMenu(colorNegotiation, menu, value, (valuen) async {
                setState(() {
                  value = valuen;
                  _presDone = value == 'True' ? true : false;
                  colorNegotiation = menu.indexOf(value) == 1 ? 0 : 1;
                  print('change ' + value);
                  irrPrescModel.negotiation = value;
                  GetFirebaseIrrPresc()
                      .ConsultIrrPresc('Irrigation-Prescription');
                  updateData('Negotiation', irrPrescModel.negotiation);
                });
              }, 'Negotiation : '),
              _downListMenu(colorMetodPresc, menuTypePresc, valueModePresc,
                  (valuet) {
                setState(() {
                  valueModePresc = valuet;
                  colorMetodPresc = menuTypePresc.indexOf(valueModePresc) + 2;
                  print('change  to ' + valueModePresc);
                  irrPrescModel.prescriptionMethod = valueModePresc;
                  print('-');
                  print(irrPrescModel.prescriptionMethod);
                  updateData(
                      'PrescriptionMethod', irrPrescModel.prescriptionMethod);
                });
              }, 'Type Prescription: ')
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting for Results'),
              )
            ];
          }
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                children: children,
              ));
        });
  }

  Future<void> updateData(variable, value) {
    return users
        .doc('Irrigation-Prescription')
        .update({variable: value})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Widget _cropProperties(idgradient, title, subtitle) {
    var gradientColor = GradientTemplate.gradientTemplate[idgradient].colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
                color: gradientColor.last.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(4, 4))
          ],
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo(title)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _textToInfo(subtitle),
          ]),
        ],
      ),
    );
  }

  Widget _downListMenu(int idgradient, List<String> menu, String valued,
      Function onChange, title) {
    var gradientColor = GradientTemplate.gradientTemplate[idgradient].colors;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
                color: gradientColor.last.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(4, 4))
          ],
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo(title)
          ]),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(
              width: 150,
              height: 50,
              child: Center(
                child: DropdownButton(
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: gradientColor[0],
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w700,
                      color: CustomColors.primaryTextColor,
                      fontSize: 15),
                  value: valued,
                  isExpanded: true,
                  onChanged: onChange,
                  items: menu.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            )
          ]),
          Row(children: <Widget>[]),
        ],
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
          fontSize: 15),
    );
  }
}
