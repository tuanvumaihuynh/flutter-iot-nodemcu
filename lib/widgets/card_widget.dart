import 'package:flutter/material.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';

class CardWidget extends StatelessWidget {
  final Map<dynamic, dynamic> messages;
  final String? node;
  final Color? color;
  final Function callBack;
  const CardWidget(
      {super.key,
      required this.node,
      required this.messages,
      required this.color,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    bool status = messages['state'];
    final size = AppLayout.getSize(context);
    final height = size.height;
    final width = size.width;
    return Center(
      child: GestureDetector(
        onTap: (() {
          callBack(node, !status);
        }),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.023),
          margin: EdgeInsets.symmetric(horizontal: width * 0.02),
          height: height * 0.27,
          width: width * 0.37,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(width * 0.07),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.051),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFFF),
                ),
                child: Image.network(
                  messages['image'],
                  scale: 2,
                ),
              ),
              Text(
                messages['name'].toString(),
                style: TextStyle(
                  color: const Color(0xFF020102),
                  fontSize: width * 0.056,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                messages['state'] == true ? "ON" : "OFF",
                style: TextStyle(
                  color: const Color(0xFF1C191A),
                  fontSize: width * 0.0382,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
