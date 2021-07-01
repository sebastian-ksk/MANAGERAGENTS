class PrescHoursModel {
  int id;
  String title;
  DateTime PrescHourDateTime;
  bool isPending;
  int gradientColorIndex;

  PrescHoursModel(
      {this.id,
      this.title,
      this.PrescHourDateTime,
      this.isPending,
      this.gradientColorIndex});

  factory PrescHoursModel.fromMap(Map<String, dynamic> json) => PrescHoursModel(
        id: json["id"],
        title: json["title"],
        PrescHourDateTime: DateTime.parse(json["PrescHourDateTime"]),
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "PrescHourDateTime": PrescHourDateTime.toIso8601String(),
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
