import 'package:rtbd_nodemcu_project/models/date_model.dart';

List<PointModel> temperaturePoint(List<DateModel> dateModelList) =>
    List<PointModel>.from(dateModelList.map((dateModel) => PointModel(
        x: dateModel.dayOfYear, y: double.parse(dateModel.temperature!))));

List<PointModel> humidityPoint(List<DateModel> dateModelList) =>
    List<PointModel>.from(dateModelList.map((dateModel) => PointModel(
        x: dateModel.dayOfYear, y: double.parse(dateModel.humidity!))));

class PointModel {
  int? x;
  double? y;
  PointModel({required this.x, required this.y});
}
