import 'package:flutter/material.dart';

class CropModel {
  String daysCrop;
  String seedDate;
  String typeCrop;
  String pwp;
  String fieldCapacity;

  CropModel(
      {@required this.daysCrop,
      @required this.seedDate,
      @required this.typeCrop,
      @required this.pwp,
      @required this.fieldCapacity});

  Map<String, String> toJson() => {
        "DaysCrop": this.daysCrop,
        "SeedDate": this.seedDate,
        "TypeCrop": this.typeCrop,
        "field_capacity": this.pwp,
        "pwp": this.fieldCapacity,
      };
}
