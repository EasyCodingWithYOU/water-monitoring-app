import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leak Detection & Alerts')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.red),
              title: const Text("Leak Detected in Kitchen Sink"),
              subtitle: const Text("Today, 08:45 AM"),
              // trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: const Icon(Icons.warning_amber, color: Colors.orange),
              title: const Text("Unusual Usage in Bathroom"),
              subtitle: const Text("Yesterday, 06:12 PM"),
              // trailing: const Icon(Icons.navigate_next),
            ),
          ],
        ),
      ),
    );
  }
}
