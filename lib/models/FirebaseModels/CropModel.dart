import 'package:flutter/material.dart';

class CropModel {
  num daysCrop;
  String seedDate;
  String typeCrop;
  num pwp;
  num fieldCapacity;

  CropModel(
      {@required this.daysCrop,
      @required this.seedDate,
      @required this.typeCrop,
      @required this.pwp,
      @required this.fieldCapacity});

  Map<String, dynamic> toJson() => {
        "DaysCrop": this.daysCrop,
        "SeedDate": this.seedDate,
        "TypeCrop": this.typeCrop,
        "field_capacity": this.pwp,
        "pwp": this.fieldCapacity,
      };

  factory CropModel.fromJson(Map<String, dynamic> json) => CropModel(
      daysCrop: json["DaysCrop"] == null ? null : json["DaysCrop"],
      seedDate: json["SeedDate"] == null ? null : json["SeedDate"],
      typeCrop: json["TypeCrop"] == null ? null : json["TypeCrop"],
      pwp: json["pwp"] == null ? null : json["pwp"],
      fieldCapacity:
          json["field_capacity"] == null ? null : json["field_capacity"]);
}
