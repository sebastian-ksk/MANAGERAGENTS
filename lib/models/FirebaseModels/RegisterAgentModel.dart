import 'package:managents/models/FirebaseModels/CropModel.dart';
import 'package:managents/models/FirebaseModels/IrrigationPropertiesModel.dart';

class RegisterAgentModel {
  CropModel crop;
  IrrigationPModel irrigationProperties;

  RegisterAgentModel({this.crop, this.irrigationProperties});

  Map<String, dynamic> toJson() => {
        "Crop": crop == null ? null : crop.toJson(),
        "Irrigation-Properties":
            irrigationProperties == null ? null : irrigationProperties.toJson()
      };
}
