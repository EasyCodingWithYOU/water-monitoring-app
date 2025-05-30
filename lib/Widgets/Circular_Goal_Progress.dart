import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularGoalProgress extends StatelessWidget {
  final double percentage;
  const CircularGoalProgress({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220.w,
            height: 220.w,
            child: CircularProgressIndicator(
              value: percentage,
              strokeWidth: 10.w,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ),
          Text(
            "${(percentage * 100).toInt()}%",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
