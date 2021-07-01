import 'package:flutter/material.dart';
import 'package:managents/util/constans/theme_data.dart';

class IrrigationState extends StatefulWidget {
  @override
  _IrrigationStateState createState() => _IrrigationStateState();
}

class _IrrigationStateState extends State<IrrigationState> {
  var gradientColor = GradientTemplate.gradientTemplate[0].colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        children: <Widget>[
          Text(
            'Irrigation State',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Image.asset(
            'assets/img/valveOpen.png',
            height: 100,
          ),
          _cropProperties(0, 'Valve State:', 'OFF'),
          _cropProperties(2, 'Last Date Irrigation :', '2021-06-11'),
          _cropProperties(0, 'Irrigation Time:', '0'),
          _cropProperties(2, 'Irrigation Applied:', '0'),
          _cropPropertiesNochanges(1, 'Irrigation Applied:', '0')
        ],
      ),
    );
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

  Widget _cropPropertiesNochanges(idgradient, title, subtitle) {
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
            _textToInfo('Nom Discharge : ' + subtitle),
          ]),
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo('Area : ' + subtitle),
          ]),
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo('# Dripers : ' + subtitle),
          ]),
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo('Efficiency : ' + subtitle),
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
