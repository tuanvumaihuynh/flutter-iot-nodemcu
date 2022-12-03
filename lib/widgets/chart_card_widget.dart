import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';
import 'package:rtbd_nodemcu_project/constants/app_styles.dart';
import 'package:rtbd_nodemcu_project/models/date_model.dart';
import 'package:rtbd_nodemcu_project/models/point_model.dart';
import 'package:rtbd_nodemcu_project/services/remote_service.dart';
import 'package:rtbd_nodemcu_project/widgets/line_chart_widget.dart';
import "package:collection/collection.dart";

const List<String> chartType = ['Temperature', 'Humidity'];

class ChartCardWidget extends StatefulWidget {
  final List<DateModel> dateModelList;

  const ChartCardWidget({super.key, required this.dateModelList});

  @override
  State<ChartCardWidget> createState() => _ChartCardWidgetState();
}

class _ChartCardWidgetState extends State<ChartCardWidget> {
  String dropdownVal = chartType.first;

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final height = size.height;
    final width = size.width;
    return Container(
      padding: EdgeInsets.only(
          left: width * 0.0509,
          right: width * 0.05,
          top: height * 0.0115,
          bottom: height * 0.0229),
      decoration: BoxDecoration(
          color: AppStyle.chartColor, borderRadius: BorderRadius.circular(30)),
      height: height * 0.31,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: dropdownVal,
                  iconSize: 0,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 2,
                  style: const TextStyle(
                      color: Color(0xFF16224A),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownVal = value!;
                    });
                  },
                  items:
                      chartType.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                GestureDetector(
                  onTap: (() {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Coming soon',
                        style: TextStyle(fontSize: 15),
                      ),
                      duration: Duration(milliseconds: 1500),
                    ));
                  }),
                  child: SizedBox(
                    width: width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text('15m', style: AppStyle.timePickText),
                        Text('1H', style: AppStyle.timePickText),
                        Text('4H', style: AppStyle.timePickText),
                        Text('1D',
                            style: AppStyle.timePickText.copyWith(
                                color: const Color(0xFF897C64),
                                fontWeight: FontWeight.bold)),
                        Text('1W', style: AppStyle.timePickText),

                        const Icon(Icons.update_outlined,
                            color: Color(0xFF16224A)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: height * 0.2,
              padding: EdgeInsets.only(right: width * 0.04),
              child: LineChartWidget(
                isTemperature: dropdownVal == 'Temperature' ? true : false,
                avgPoint: getAveragePointMap(),
              ))
        ],
      ),
    );
  }

  Map<int, double> getAveragePointMap() {
    List<PointModel> pointModelList = dropdownVal == 'Temperature'
        ? temperaturePoint(widget.dateModelList)
        : humidityPoint(widget.dateModelList);
    final tempMap = <int, List<double>>{};
    for (final pointModel in pointModelList) {
      tempMap.update(pointModel.x!, (value) => value..add(pointModel.y!),
          ifAbsent: (() => [pointModel.y!]));
    }
    final avgPoint = tempMap.map((key, value) => MapEntry(
        key, value.reduce((before, after) => before + after) / value.length));
    return avgPoint;
  }
}
