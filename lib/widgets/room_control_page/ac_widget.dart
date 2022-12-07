import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';

class ACWidget extends StatefulWidget {
  final double? temp;
  const ACWidget({super.key, required this.temp});

  @override
  State<ACWidget> createState() => _ACWidgetState();
}

class _ACWidgetState extends State<ACWidget> {
  bool _status = true;
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final height = size.height;
    final width = size.width;
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.06, vertical: height * 0.023),
        height: height * 0.118,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Colors.black12,
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Temperature',
                  style: TextStyle(
                    color: const Color(0xFF979696),
                    fontSize: width * 0.041,
                  ),
                ),
                SizedBox(height: height * 0.0172),
                Text(
                  '${widget.temp.toString()}°C',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.056,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            FlutterSwitch(
              width: width * 0.127,
              height: width * 0.073,
              toggleSize: width * 0.051,
              value: _status,
              borderRadius: 50.0,
              padding: width * 0.013,
              onToggle: (bool value) {
                setState(() {
                  _status = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
