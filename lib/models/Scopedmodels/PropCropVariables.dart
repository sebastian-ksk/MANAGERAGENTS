import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managents/models/CropVariable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnectedModel extends Model {
  List<CropVariable> __variablesList = [
    CropVariable(
        title: 'Prescription',
        subtitle: 'No Negotiation',
        leftIcon: FontAwesomeIcons.eyeDropper,
        isEnable: true),
    CropVariable(
        title: 'Sensors',
        subtitle: '22 °C',
        leftIcon: FontAwesomeIcons.thermometer,
        isEnable: false),
    CropVariable(
        title: 'Irrigation',
        subtitle: 'OFF',
        leftIcon: FontAwesomeIcons.water,
        isEnable: false),
    CropVariable(
        title: 'Crop',
        subtitle: 'Potato ',
        leftIcon: FontAwesomeIcons.seedling,
        isEnable: false),
  ];
}

class PropCropVariables extends ConnectedModel {
  List<CropVariable> get allYatch {
    return List.from(__variablesList);
  }
}
