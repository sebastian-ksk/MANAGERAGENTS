import 'package:flutter/material.dart';
import 'package:managents/data/Firebase/IrrPrescGet.dart';
import 'package:managents/models/FirebaseModels/IrrigationPropertiesModel.dart';
import 'package:managents/models/FirebaseModels/ResultPrescIrrModel.dart';
import 'package:managents/util/constans/theme_data.dart';

class IrrigationState extends StatefulWidget {
  @override
  _IrrigationStateState createState() => _IrrigationStateState();
}

class _IrrigationStateState extends State<IrrigationState> {
  var gradientColor = GradientTemplate.gradientTemplate[0].colors;
  IrrigationPModel irrigationProp;

  @override
  void initState() {
    super.initState();
    _parameterInitializacon();
  }

  _parameterInitializacon() async {
    irrigationProp = await GetFirebaseIrrPresc().ConsultIrrigationProperties();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResultPrescIrrModel>(
        stream: GetFirebaseIrrPresc().ConsultResultIrrPrescStream(),
        builder: (_, AsyncSnapshot<ResultPrescIrrModel> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
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
                snapshot.data.irrigationState == 'on'
                    ? 'assets/img/valveOpen.png'
                    : 'assets/img/valveClosed.png',
                height: 80,
              ),
              _cropProperties(
                  0, 'Valve State:', snapshot.data?.irrigationState ?? 'Indf'),
              _cropProperties(2, 'Last Date Irrigation :',
                  snapshot.data?.lastIrrigationDate ?? '0/0/0'),
              _cropProperties(0, 'Irrigation Time:',
                  snapshot.data?.irrigationTime.toString() ?? 'indf'),
              _cropProperties(2, 'Irrigation Applied:',
                  snapshot.data?.irrigationApplied.toString() ?? 'indf'),
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
