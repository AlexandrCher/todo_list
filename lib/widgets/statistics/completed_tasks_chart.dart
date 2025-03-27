import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../helpers/format_datetime.dart';

class CompletedTasksChart extends StatelessWidget {
  final List<int> completedTasks;

  const CompletedTasksChart({Key? key, required this.completedTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: List.generate(7, (index) {
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: completedTasks[index].toDouble(),
                color: Colors.blue,
              ),
            ],
          );
        }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final date =
                    DateTime.now().subtract(Duration(days: 6 - value.toInt()));
                return Text(formatDateForChart(date));
              },
            ),
          ),
        ),
      ),
    );
  }
}
