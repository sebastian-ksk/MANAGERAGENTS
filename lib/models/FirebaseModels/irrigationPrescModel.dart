import 'package:flutter/material.dart';

class IrrPrescModel {
  String irrigationMethod;
  String firstIrrigationTime;
  String secondIrrigationTime;
  String negotiation;
  String prescriptionMethod;
  String prescriptionTime;
  int constanFlow;
  String manualValves;

  IrrPrescModel(
      {@required this.irrigationMethod,
      @required this.firstIrrigationTime,
      @required this.secondIrrigationTime,
      @required this.negotiation,
      @required this.prescriptionMethod,
      @required this.prescriptionTime,
      @required this.constanFlow,
      @required this.manualValves});

  factory IrrPrescModel.fromJson(Map<String, dynamic> json) => IrrPrescModel(
        irrigationMethod: json["IrrigationMethod "] == null
            ? null
            : json["IrrigationMethod "],
        firstIrrigationTime:
            json["IrrigationTime_2"] == null ? null : json["IrrigationTime_2"],
        secondIrrigationTime:
            json["IrrigationTime_1"] == null ? null : json["IrrigationTime_1"],
        negotiation: json["Negotiation"] == null ? null : json["Negotiation"],
        prescriptionMethod: json["PrescriptionMethod"] == null
            ? null
            : json["PrescriptionMethod"],
        prescriptionTime:
            json["PrescriptionTime"] == null ? null : json["PrescriptionTime"],
        constanFlow: json["constanFlow"] == null ? null : json["constanFlow"],
        manualValves:
            json["manualValves"] == null ? null : json["manualValves"],
      );

  Map<String, dynamic> toJson() => {
        "IrrigationMethod ": this.irrigationMethod,
        "IrrigationTime_2": this.secondIrrigationTime,
        "Negotiation": this.negotiation,
        "PrescriptionMethod": this.prescriptionMethod,
        "PrescriptionTime": this.prescriptionTime,
        "IrrigationTime_1": this.firstIrrigationTime,
        "constanFlow": this.constanFlow,
        "manualValves": this.manualValves
      };
}
