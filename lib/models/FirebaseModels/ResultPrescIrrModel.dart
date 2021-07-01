import 'package:flutter/material.dart';

class ResultPrescIrrModel {
  String irrigationState;
  num irrigationTime;
  String lastIrrigationDate;
  String lastPrescriptionDate;
  num netPrescription;
  num irrigationApplied;

  ResultPrescIrrModel(
      {@required this.irrigationState,
      @required this.irrigationTime,
      @required this.lastIrrigationDate,
      @required this.lastPrescriptionDate,
      @required this.netPrescription,
      @required this.irrigationApplied});

  factory ResultPrescIrrModel.fromJson(Map<String, dynamic> json) =>
      ResultPrescIrrModel(
        irrigationState:
            json["IrrigationState "] == null ? null : json["IrrigationState "],
        irrigationTime:
            json["IrrigationTime"] == null ? null : json["IrrigationTime"],
        lastIrrigationDate: json["LastIrrigationDate"] == null
            ? null
            : json["LastIrrigationDate"],
        netPrescription:
            json["NetPrescription"] == null ? null : json["NetPrescription"],
        irrigationApplied: json["irrigationApplied"] == null
            ? null
            : json["irrigationApplied"],
        lastPrescriptionDate: json["LastPrescriptionDate"] == null
            ? null
            : json["LastPrescriptionDate"],
      );

  Map<String, dynamic> toJson() => {
        "dev_id": this.irrigationState,
        "dev_name": this.irrigationTime,
        "dev_description": this.lastIrrigationDate,
        "dev_tech": this.lastPrescriptionDate,
        "dev_type": this.netPrescription,
        "dev_maker": this.irrigationApplied,
      };
}
