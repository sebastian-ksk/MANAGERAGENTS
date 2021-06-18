class IrrigHoursModel {
  int id;
  String title;
  DateTime IrrigHourDateTime;
  bool isPending;
  int gradientColorIndex;

  IrrigHoursModel(
      {this.id,
      this.title,
      this.IrrigHourDateTime,
      this.isPending,
      this.gradientColorIndex});

  factory IrrigHoursModel.fromMap(Map<String, dynamic> json) => IrrigHoursModel(
        id: json["id"],
        title: json["title"],
        IrrigHourDateTime: DateTime.parse(json["IrrigHourDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "IrrigHourDateTime": IrrigHourDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
