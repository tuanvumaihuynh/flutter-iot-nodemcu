import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rtbd_nodemcu_project/constants/app_layout.dart';

class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    final height = size.height;
    final width = size.width;
    return SizedBox(
      height: height * 0.3,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFFFFBF3),
        highlightColor: Colors.grey,
        child: Container(
          height: height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF897C64),
          ),
        ),
      ),
    );
  }
}
