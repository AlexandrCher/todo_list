import 'package:flutter/material.dart';

import '../model/task.dart';
import '../widgets/statistics/completed_tasks_chart.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Task> tasks;

  const StatisticsScreen({Key? key, required this.tasks}) : super(key: key);

  List<int> getCompletedTasksByDay() {
    List<int> completedTasks = List.filled(7, 0);
    DateTime now = DateTime.now();

    for (var task in tasks) {
      if (task.isCompleted && task.completionDate != null) {
        int daysAgo = now.difference(task.completionDate!).inDays;
        if (daysAgo < 7) {
          completedTasks[6 - daysAgo]++;
        }
      }
    }

    return completedTasks;
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = getCompletedTasksByDay();

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Completed Tasks in the Last 7 Days'),
            SizedBox(height: 16),
            Expanded(
              child: CompletedTasksChart(completedTasks: completedTasks),
            ),
          ],
        ),
      ),
    );
  }
}