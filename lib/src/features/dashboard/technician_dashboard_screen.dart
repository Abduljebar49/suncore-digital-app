import 'package:flutter/material.dart';

class TechnicianDashboardScreen extends StatelessWidget {
    final String userName;
  final VoidCallback onLogout;

  const TechnicianDashboardScreen({
    super.key,
    required this.userName,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Field Monitoring Dashboard')),
      body: const Column(
        children: [
          // Real-time equipment monitoring
          // EquipmentStatusPanel(),
          // EnvironmentalConditionsPanel(),
          // AlertSummaryPanel(),
        ],
      ),
    );
  }
}