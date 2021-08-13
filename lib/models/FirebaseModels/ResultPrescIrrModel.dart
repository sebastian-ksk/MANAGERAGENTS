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
            json["IrrigationState"] == null ? null : json["IrrigationState"],
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
        "IrrigationState": this.irrigationState,
        "IrrigationTime": this.irrigationTime,
        "LastIrrigationDate": this.lastIrrigationDate,
        "LastPrescriptionDate": this.lastPrescriptionDate,
        "NetPrescription": this.netPrescription,
        "irrigationApplied": this.irrigationApplied,
      };
}
