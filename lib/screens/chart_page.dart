import 'package:flutter/material.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';
import 'package:rtbd_nodemcu_project/constants/app_styles.dart';
import 'package:rtbd_nodemcu_project/models/date_model.dart';
import 'package:rtbd_nodemcu_project/services/remote_service.dart';
import 'package:rtbd_nodemcu_project/widgets/chart_page/chart_card_widget.dart';
import 'package:rtbd_nodemcu_project/widgets/chart_page/line_chart_widget.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late List<DateModel> dateModelList;

  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                  "Chart",
                  style: TextStyle(
                      color: const Color(0xFF141414),
                      fontSize: width * 0.051,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: (() {
                    getData();
                  }),
                  child: Icon(
                    Icons.settings,
                    size: width * 0.076,
                    color: const Color(0xFF16224A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            isLoaded == true
                ? ChartCardWidget(
                    dateModelList: dateModelList,
                  )
                : Column(
                    children: [
                      SizedBox(height: height * 0.1),
                      const CircularProgressIndicator(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    dateModelList = await RemoteService().getPosts();
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }
}
