import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';
import 'package:rtbd_nodemcu_project/constants/app_styles.dart';
import 'package:rtbd_nodemcu_project/widgets/ac_widget.dart';
import 'package:rtbd_nodemcu_project/widgets/card_widget.dart';

class RoomControlPage extends StatefulWidget {
  final Map<dynamic, dynamic> messages;
  final dynamic keys;
  const RoomControlPage({
    Key? key,
    required this.messages,
    required this.keys,
  }) : super(key: key);

  @override
  State<RoomControlPage> createState() => _RoomControlPageState();
}

class _RoomControlPageState extends State<RoomControlPage> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("iot/home/");

  dynamic getMap(Map<dynamic, dynamic> map) {
    for (var i = 0; i < map.length; i++) {
      if (map.values.toList()[i]['name'] == widget.messages['name']) {
        return map.values.elementAt(i);
      }
    }
  }

  void changeStateDevice(String node, bool state) {
    _dbRef.update({node: state});
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            left: width * 0.051,
            right: width * 0.051,
            bottom: height * 0.0345,
            top: height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: width * 0.076,
                  ),
                ),
                Text(
                  widget.messages['name'],
                  style: TextStyle(
                      color: const Color(0xFF141414),
                      fontSize: width * 0.051,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.settings,
                  size: width * 0.076,
                  color: const Color(0xFF16224A),
                ),
              ],
            ),
            SizedBox(height: height * 0.0344),
            StreamBuilder(
              stream: _dbRef.onValue,
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final myMessages = Map<dynamic, dynamic>.from(
                      (streamSnapshot.data as DatabaseEvent).snapshot.value
                          as Map<dynamic, dynamic>);

                  Map<dynamic, dynamic> mesVal = getMap(myMessages);
                  final temperature =
                      mesVal['devices']['dht']['temperature'].toDouble();
                  final humidity =
                      mesVal['devices']['dht']['humidity'].toDouble();
                  Map<dynamic, dynamic> devices = mesVal['devices'];
                  final node = '${widget.keys}/devices/';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Air Conditioner',
                        style: TextStyle(
                            color: const Color(0xFF131313),
                            fontSize: width * 0.071,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.023),
                      ACWidget(temp: temperature),
                      SizedBox(height: height * 0.04),
                      Center(
                        child: CircularPercentIndicator(
                          startAngle: 0,
                          animation: true,
                          animationDuration: 600,
                          radius: width * 0.255,
                          lineWidth: width * 0.0763,
                          percent: humidity * 0.01,
                          progressColor: const Color(0xFFD1E5F7),
                          backgroundColor: const Color(0xFFF6F6F6),
                          center: Text(
                            "$humidity%",
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.0115),
                      Text(
                        'Devices',
                        style: TextStyle(
                            color: const Color(0xFF131313),
                            fontSize: width * 0.071,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.0115),
                      SizedBox(
                        height: height * 0.3,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: devices.values.length,
                          itemBuilder: ((context, index) {
                            return CardWidget(
                              node:
                                  '$node${devices.keys.elementAt(index)}/state',
                              callBack: changeStateDevice,
                              messages: devices.values.elementAt(index),
                              color: AppStyle.listColor[index],
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: SizedBox(
                    height: width * 0.2,
                    width: width * 0.2,
                    child: const CircularProgressIndicator(
                      strokeWidth: 10,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
