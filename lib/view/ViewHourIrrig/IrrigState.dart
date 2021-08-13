import 'package:flutter/material.dart';
import 'package:managents/data/Firebase/IrrPrescGet.dart';
import 'package:managents/models/FirebaseModels/IrrigationPropertiesModel.dart';
import 'package:managents/models/FirebaseModels/ResultPrescIrrModel.dart';
import 'package:managents/models/FirebaseModels/irrigationPrescModel.dart';
import 'package:managents/providers/HomePageProvider.dart';
import 'package:managents/util/constans/theme_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class IrrigationState extends StatefulWidget {
  String currentUser;
  String currentAgent;
  IrrigationState({
    Key key,
    @required this.currentUser,
    @required this.currentAgent,
  });

  @override
  _IrrigationStateState createState() => _IrrigationStateState();
}

class _IrrigationStateState extends State<IrrigationState> {
  var gradientColor = GradientTemplate.gradientTemplate[0].colors;
  IrrigationPModel irrigationProp;
  ResultPrescIrrModel resultsAgent;
  Stream<DocumentSnapshot> _resultAgent = FirebaseFirestore.instance
      .collection('user')
      .doc('Irrigation-Prescription')
      .snapshots();

  @override
  void initState() {
    _resultAgent = FirebaseFirestore.instance
        .collection('${widget.currentUser}.${widget.currentAgent}')
        .doc('ResultIrrigation-Prescription')
        .snapshots();

    super.initState();
    _parameterInitializacon();
  }

  _parameterInitializacon() async {
    irrigationProp = await GetFirebaseIrrPresc().ConsultIrrigationProperties(
        '${widget.currentUser}.${widget.currentUser}');
  }

  @override
  Widget build(BuildContext context) {
    final _agentProperties = Provider.of<HomePageProvider>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: _resultAgent,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            print(snapshot.data.data());
            resultsAgent = ResultPrescIrrModel.fromJson(snapshot.data.data());
            print(resultsAgent.irrigationApplied);

            _agentProperties.irrigationApplied =
                resultsAgent.irrigationApplied.toString();

            children = <Widget>[
              Text(
                'Irrigation State',
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    color: CustomColors.primaryTextColor,
                    fontSize: 24),
              ),
              Image.asset(
                resultsAgent.irrigationState == 'ON'
                    ? 'assets/img/valveOpen.png'
                    : 'assets/img/valveClosed.png',
                height: 80,
              ),
              _cropProperties(
                  0, 'Valve State:', resultsAgent?.irrigationState ?? 'Indf'),
              _cropProperties(2, 'Last Date Irrigation :',
                  resultsAgent?.lastIrrigationDate ?? '0/0/0'),
              _cropProperties(0, 'Irrigation Time:',
                  '${resultsAgent?.irrigationTime.toString() ?? '--'} Min'),
              _cropProperties(2, 'Irrigation Applied:',
                  '${resultsAgent?.irrigationApplied.toString() ?? '--'} mm'),
              _cropPropertiesNochanges(
                1,
                irrigationProp?.nominalDischarge?.toString() ?? '0',
                irrigationProp?.area?.toString() ?? '0',
                irrigationProp?.drippers?.toString() ?? '0',
                irrigationProp?.efficiency?.toString() ?? '0',
              )
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
            constraints: BoxConstraints(
              maxHeight: double.infinity,
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
            child: Column(
              children: children,
            ),
          );
        });
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

  Widget _cropPropertiesNochanges(
      idgradient, NomDischarge, Area, drippers, Efficience) {
    var gradientColor = GradientTemplate.gradientTemplate[idgradient].colors;
    return Container(
      constraints: BoxConstraints(
        maxHeight: double.infinity,
      ),
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
          Column(
            children: [
              Row(children: <Widget>[
                Icon(
                  Icons.label,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 8),
                _textToInfo('Nom Discharge : '),
              ]),
              _textToInfo(NomDischarge),
            ],
          ),
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo('Area : ' + Area),
          ]),
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo('# Dripers : ' + drippers)
          ]),
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo('Efficiency : ' + Efficience),
          ]),
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
