import 'package:managents/models/FirebaseModels/CropModel.dart';
import 'package:managents/models/FirebaseModels/IrrigationPropertiesModel.dart';
import 'package:managents/models/FirebaseModels/ResultPrescIrrModel.dart';
import 'package:managents/models/FirebaseModels/irrigationPrescModel.dart';

class AgentModel {
  CropModel crop;
  IrrigationPModel irrigationProperties;
  IrrPrescModel irrigationPrescription;
  ResultPrescIrrModel resultIrrigationPrescription;
  AgentModel({
    this.crop,
    this.irrigationProperties,
    this.irrigationPrescription,
    this.resultIrrigationPrescription,
  });

  Map<String, dynamic> toJson() => {
        "Crop": crop == null ? null : crop.toJson(),
        "Irrigation-Properties":
            irrigationProperties == null ? null : irrigationProperties.toJson(),
        "Irrigation-Prescription": irrigationPrescription == null
            ? null
            : irrigationPrescription.toJson(),
        "ResultIrrigation-Prescription": resultIrrigationPrescription == null
            ? null
            : resultIrrigationPrescription.toJson()
      };

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
      crop: json["Crop"] == null ? null : CropModel.fromJson(json["Crop"]),
      irrigationPrescription: json["Irrigation-Prescription"] == null
          ? null
          : IrrPrescModel.fromJson(json["Irrigation-Prescription"]),
      irrigationProperties: json["Irrigation-Properties"] == null
          ? null
          : IrrigationPModel.fromJson(json["Irrigation-Properties"]),
      resultIrrigationPrescription:
          json["ResultIrrigation-Prescription"] == null
              ? null
              : ResultPrescIrrModel.fromJson(json["LastIrrigationDate"]));
}
