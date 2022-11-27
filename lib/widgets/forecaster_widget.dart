import 'package:flutter/material.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';

class ForecasterWidget extends StatelessWidget {
  const ForecasterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final height = size.height;
    final width = size.width;
    return Center(
      child: Container(
        padding: EdgeInsets.only(
            bottom: height * 0.04,
            left: height * 0.04,
            top: height * 0.04,
            right: height * 0.05),
        margin: EdgeInsets.only(top: height * 0.03, bottom: height * 0.03),
        height: height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1F8CFC), Color(0xFF8EC1F1)]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons8-sun-behind-large-cloud-96.png',
                  scale: 1.5,
                ),
                Text(
                  "Cloudy",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.0636,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '26 November 2022',
                  style:
                      TextStyle(color: Colors.white, fontSize: width * 0.0407),
                ),
                Text(
                  '28°C',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.1527,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
