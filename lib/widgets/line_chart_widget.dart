import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rtbd_nodemcu_project/constants/app_styles.dart';
import 'package:rtbd_nodemcu_project/models/date_model.dart';
import 'package:rtbd_nodemcu_project/models/point_model.dart';

const List months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

class LineChartWidget extends StatelessWidget {
  final bool isTemperature;
  final Map<int, double> avgPoint;
  const LineChartWidget(
      {super.key, required this.isTemperature, required this.avgPoint});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isTemperature ? temperatureChart() : humidityChart(),
      swapAnimationDuration: const Duration(milliseconds: 1500),
      swapAnimationCurve: Curves.easeOutCubic,
    );
  }

  LineChartData temperatureChart() {
    return LineChartData(
      backgroundColor: AppStyle.chartColor,
      lineTouchData: lineTouchData1(),
      titlesData: customTitlesData(),
      borderData: FlBorderData(show: false),
      lineBarsData: [lineChartBarData()],
      minX: avgPoint.keys.first.toDouble(),
      maxX: avgPoint.keys.last.toDouble(),
      minY: 0,
      maxY: 40,
    );
  }

  LineChartData humidityChart() {
    return LineChartData(
      backgroundColor: AppStyle.chartColor,
      lineTouchData: lineTouchData2(),
      titlesData: customTitlesData(),
      borderData: FlBorderData(show: false),
      lineBarsData: [lineChartBarData()],
      minX: avgPoint.keys.first.toDouble(),
      maxX: avgPoint.keys.last.toDouble(),
      minY: 0,
      maxY: 100,
    );
  }

  LineChartBarData lineChartBarData() {
    return LineChartBarData(
      isCurved: true,
      color: isTemperature ? Colors.red : Colors.lightBlue,
      barWidth: 3,
      isStrokeCapRound: false,
      dotData: FlDotData(show: false),
      spots: avgPoint.entries
          .map((entry) => FlSpot(entry.key.toDouble(),
              double.parse(entry.value.toStringAsFixed(1))))
          .toList(),
    );
  }

  // Touch chart event and custom
  LineTouchData lineTouchData1() {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black.withOpacity(0.1),
          tooltipRoundedRadius: 10),
    );
  }

  LineTouchData lineTouchData2() {
    return LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.black.withOpacity(0.1),
          tooltipRoundedRadius: 10),
    );
  }

  /// Show, hide title and custom
  FlTitlesData customTitlesData() {
    return FlTitlesData(
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: bottomTitles()),
        leftTitles: AxisTitles(sideTitles: leftTitles()));
  }

  SideTitles leftTitles() {
    return SideTitles(
        getTitlesWidget: leftTitleWidget, showTitles: true, reservedSize: 25);
  }

  Widget leftTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF897C64),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;

      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget bottomTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF897C64),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = "";
    List listAvg = avgPoint.entries.toList();
    for (var i in indexDate()) {
      if (listAvg[i].key == value) {
        final cvt2Dt = convert2Dt(value.toInt());
        text = "${months[cvt2Dt.month - 1]} ${cvt2Dt.day}";
      }
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(text, style: style),
    );
  }

  SideTitles bottomTitles() {
    return SideTitles(
        getTitlesWidget: bottomTitleWidget, showTitles: true, reservedSize: 25);
  }

  List indexDate() {
    final length = avgPoint.length;

    if (length % 2 != 0) {
      return [0, length ~/ 4 + 2, length - length ~/ 4 - 3, length - 1];
    }
    return [0, length ~/ 4 + 2, length - length ~/ 4 - 2, length - 1];
  }
}

/// Convert the day of year to DateTime Object
DateTime convert2Dt(int dayOfYear) {
  var millisInADay = Duration(days: 1).inMilliseconds; // 86400000
  var millisDayOfYear = (dayOfYear + 1) * millisInADay;
  var millisecondsSinceEpoch =
      DateTime(DateTime.now().year).millisecondsSinceEpoch;
  var dayOfYearDate = DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch + millisDayOfYear,
      isUtc: true);
  return dayOfYearDate;
}
