import 'package:flutter/material.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';
import 'package:rtbd_nodemcu_project/screens/room_control_page.dart';

class RoomWidget extends StatefulWidget {
  final Map<dynamic, dynamic> messages;
  final dynamic keys;
  final Color? color;

  const RoomWidget({
    Key? key,
    required this.keys,
    required this.messages,
    required this.color,
  }) : super(key: key);

  @override
  State<RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final height = size.height;
    final width = size.width;
    return Center(
      child: GestureDetector(
        onTap: (() {
          // print(widget.messages.keys);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomControlPage(
                messages: widget.messages,
                keys: widget.keys,
              ),
            ),
          );
        }),
        child: Container(
          padding: EdgeInsets.only(
              left: width * 0.076, top: width * 0.089, bottom: width * 0.089),
          margin: EdgeInsets.symmetric(vertical: width * 0.0254),
          height: height * 0.15,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.038),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFFFFF),
                ),
                child: Image.network(
                  widget.messages['image'],
                  scale: 2,
                ),
              ),
              SizedBox(width: width * 0.0636),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.messages['name']}',
                    style: TextStyle(
                        color: const Color(0xFF020102),
                        fontSize: width * 0.0636,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: width * 0.0255,
                        width: width * 0.0255,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8ED36D),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: width * 0.0255),
                      Text(
                        "${widget.messages['devices'].length} Devices",
                        style: const TextStyle(
                            color: Color(0xFF1C191A),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
