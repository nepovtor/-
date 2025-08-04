import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/admin_stats.dart';

/// Displays a pie chart of user role distribution.
class UserStatsChart extends StatelessWidget {
  final AdminStats stats;
  const UserStatsChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final sections = <PieChartSectionData>[
      PieChartSectionData(
        value: stats.adminCount.toDouble(),
        color: Colors.red,
        title: 'Admins',
      ),
      PieChartSectionData(
        value: stats.seniorLeaderCount.toDouble(),
        color: Colors.orange,
        title: 'Senior',
      ),
      PieChartSectionData(
        value: (stats.leaderCount - stats.seniorLeaderCount).toDouble(),
        color: Colors.blue,
        title: 'Leaders',
      ),
      PieChartSectionData(
        value: stats.assistantCount.toDouble(),
        color: Colors.green,
        title: 'Assist',
      ),
    ].where((e) => e.value > 0).toList();

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 0,
          sections: sections,
        ),
      ),
    );
  }
}
