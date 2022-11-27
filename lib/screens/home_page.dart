import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';
import 'package:rtbd_nodemcu_project/constants/app_styles.dart';
import 'package:rtbd_nodemcu_project/widgets/forecaster_widget.dart';
import 'package:rtbd_nodemcu_project/widgets/room_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("iot/home/");
  showPopupMenu() {
    showMenu<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: context,
      position: const RelativeRect.fromLTRB(15, 20.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
            value: '1',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification',
                  style: AppStyle.popUpText,
                ),
                Icon(
                  Icons.notifications_none,
                  size: 25,
                  color: AppStyle.titleColor,
                ),
              ],
            )),
        PopupMenuItem<String>(
            value: '2',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About app',
                  style: AppStyle.popUpText,
                ),
                Icon(
                  Icons.info_outline_rounded,
                  size: 25,
                  color: AppStyle.titleColor,
                ),
              ],
            )),
        PopupMenuItem<String>(
            value: '3',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exit',
                  style: AppStyle.popUpText,
                ),
                Icon(
                  Icons.logout_rounded,
                  size: 25,
                  color: AppStyle.titleColor,
                ),
              ],
            )),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
      } else if (itemSelected == "2") {
        //code here
      } else {
        SystemNavigator.pop();
      }
    });
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Vu',
                      style: AppStyle.headLine,
                    ),
                    SizedBox(height: height * 0.0057),
                    Text(
                      'Welcome to your home',
                      style: AppStyle.bodyText,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showPopupMenu();
                  },
                  child: Icon(
                    Icons.settings,
                    size: width * 0.0763,
                    color: const Color(0xFF16224A),
                  ),
                ),
              ],
            ),
            const ForecasterWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Rooms',
                  style: TextStyle(
                    color: const Color(0xFF16224A),
                    fontSize: width * 0.0713,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: height * 0.0458,
                  width: width * 0.1527,
                  padding: EdgeInsets.only(
                      right: width * 0.0255, left: width * 0.0127),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F6F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: const Color(0xFF4DBDBE),
                        size: width * 0.0382,
                      ),
                      Text(
                        'Add',
                        style: TextStyle(
                          color: const Color(0xFF4DBDBE),
                          fontSize: width * 0.0382,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.0115,
            ),
            StreamBuilder(
                stream: _dbRef.onValue,
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final myMessages = Map<dynamic, dynamic>.from(
                        (streamSnapshot.data as DatabaseEvent).snapshot.value
                            as Map<dynamic, dynamic>);

                    return Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: myMessages.length,
                          itemBuilder: ((context, index) {
                            return RoomWidget(
                              keys: myMessages.keys.elementAt(index),
                              messages: myMessages.values.elementAt(index),
                              color: AppStyle.listColor[index],
                            );
                          })),
                    );
                  }
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
