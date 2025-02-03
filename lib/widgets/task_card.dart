import 'package:flutter/material.dart';
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
    return ListTile(
      title: Text(
        task.title,
        style: task.isCompleted
            ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                )
            : Theme.of(context).textTheme.bodyLarge,
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