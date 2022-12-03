import 'dart:convert';

List<DateModel> dateModelFromJson(String str) =>
    List<DateModel>.from(json.decode(str).map((x) => DateModel.fromJson(x)));

String dateModelToJson(List<DateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DateModel {
  DateModel(
      {required this.date,
      required this.time,
      required this.temperature,
      required this.humidity,
      required this.dayOfYear});

  String? date;
  int dayOfYear = 0;
  String? time;
  String? temperature;
  String? humidity;

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        date: json["date"],
        time: json["time"],
        temperature: json["temperature"].toString(),
        humidity: json["humidity"].toString(),
        dayOfYear: theDayOfYear(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "temperature": temperature,
        "humidity": humidity,
      };
}

int theDayOfYear(date) {
  final dateSplit = date.split('-').toList();
  final dateObject = DateTime(int.parse(dateSplit[2]), int.parse(dateSplit[1]),
      int.parse(dateSplit[0]), 0, 0);
  final stone = DateTime(2022, 1, 1, 0, 0);
  final diff = dateObject.difference(stone).inDays;
  return diff;
}
