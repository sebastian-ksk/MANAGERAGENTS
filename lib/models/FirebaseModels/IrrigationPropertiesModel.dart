import 'package:flutter/material.dart';

class IrrigationPModel {
  String area;
  String drippers;
  String efficiency;
  String nominalDischarge;

  IrrigationPModel(
      {@required this.area,
      @required this.drippers,
      @required this.efficiency,
      @required this.nominalDischarge});

  Map<String, String> toJson() => {
        "dev_id": this.area,
        "drippers": this.drippers,
        "dev_description": this.efficiency,
        "dev_tech": this.nominalDischarge,
      };
}
