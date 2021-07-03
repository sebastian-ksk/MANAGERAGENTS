import 'package:flutter/material.dart';

class IrrigationPModel {
  num area;
  num drippers;
  num efficiency;
  num nominalDischarge;

  IrrigationPModel(
      {@required this.area,
      @required this.drippers,
      @required this.efficiency,
      @required this.nominalDischarge});

  Map<String, dynamic> toJson() => {
        "area": this.area,
        "drippers": this.drippers,
        "efficiency": this.efficiency,
        "nominalDischarge": this.nominalDischarge,
      };
  factory IrrigationPModel.fromJson(Map<String, dynamic> json) =>
      IrrigationPModel(
        area: json["area"] == null ? null : json["area"],
        drippers: json["drippers"] == null ? null : json["drippers"],
        efficiency: json["efficiency"] == null ? null : json["efficiency"],
        nominalDischarge:
            json["nominalDischarge"] == null ? null : json["nominalDischarge"],
      );
}
