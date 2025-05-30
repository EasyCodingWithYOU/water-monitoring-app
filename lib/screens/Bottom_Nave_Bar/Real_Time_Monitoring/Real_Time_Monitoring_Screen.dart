import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pro/Widgets/Circular_Goal_Progress.dart';

class RealTimeMonitorScreen extends StatelessWidget {
  const RealTimeMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-Time Monitoring')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Flow Rate (L/min)",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200.h,
              child: LineChart(
                LineChartData(
                  // titlesData: FlTitlesData(
                  //   bottomTitles: AxisTitles(
                  //     sideTitles: SideTitles(
                  //       showTitles: true,
                  //       getTitlesWidget: (value, meta) {
                  //         const days = [
                  //           'Mon',
                  //           'Tue',
                  //           'Wed',
                  //           'Thu',
                  //           'Fri',
                  //           'Sat',
                  //           'Sun',
                  //         ];
                  //         return Text(
                  //           days[value.toInt() % days.length],
                  //           style: TextStyle(fontSize: 10.sp),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  titlesData: FlTitlesData(show: true),
                  gridData: FlGridData(
                    show: true,
                    // getDrawingHorizontalLine: (value) {
                    //   return FlLine(
                    //     color: Colors.blueAccent,
                    //     dashArray: [5, 5],
                    //   );
                    // },
                    // getDrawingVerticalLine: (value) {
                    //   return FlLine(
                    //     color: Colors.blueAccent,
                    //     dashArray: [5, 5],
                    //   );
                    // },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 1.5),
                        FlSpot(2, 1.4),
                        FlSpot(3, 3.4),
                        FlSpot(4, 2),
                        FlSpot(5, 2.2),
                      ],
                      isCurved: true,
                      color: Colors.blueAccent,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Today's Water Usage",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.h),
            CircularGoalProgress(percentage: 0.55),
          ],
        ),
      ),
    );
  }
}
