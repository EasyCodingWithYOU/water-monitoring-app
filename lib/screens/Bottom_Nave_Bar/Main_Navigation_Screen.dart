import 'package:flutter/material.dart';

import 'package:new_pro/screens/Bottom_Nave_Bar/Alert/Alert_Screen.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Analytic/Analytic_Screen.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Billing/Billing_Screen.dart';
import 'package:new_pro/screens/Bottom_Nave_Bar/Real_Time_Monitoring/Real_Time_Monitoring_Screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    RealTimeMonitorScreen(),
    AnalyticsScreen(),
    AlertsScreen(),
    BillingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.water), label: 'Monitor'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Alerts'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Billing',
          ),
        ],
      ),
    );
  }
}
