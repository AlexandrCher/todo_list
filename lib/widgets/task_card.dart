import 'package:flutter/material.dart';
import 'package:todo_list/helpers/format_datetime.dart';
import 'package:todo_list/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleCompletion;
  final VoidCallback onDelete;

  TaskCard({
    required this.task,
    required this.onToggleCompletion,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color? completionColor;
    if (task.isCompleted && task.completionDate != null) {
      completionColor = task.completionDate!.isBefore(task.deadline)
          ? Colors.green
          : Colors.red;
    }

    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: task.isCompleted
                ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    )
                : Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Deadline: ${formatDateTime(task.deadline)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (task.isCompleted && task.completionDate != null)
            Text(
              'Completed: ${formatDateTime(task.completionDate!)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: completionColor,
                  ),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              task.isCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onPressed: onToggleCompletion,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}