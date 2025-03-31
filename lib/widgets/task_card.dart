import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/helpers/format_datetime.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/theme/custom_colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleCompletion;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  TaskCard({
    required this.task,
    required this.onToggleCompletion,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>();
    Color? completionColor;
    if (task.isCompleted &&
        task.completionDate != null &&
        task.deadline != null) {
      completionColor = task.completionDate!.isBefore(task.deadline!)
          ? Colors.green
          : Colors.red;
    }

    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onEdit(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        tileColor: customColors?.customBackgroundColor ?? Colors.grey,
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
                  : Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: customColors?.customTextColor ?? Colors.black,
                      ),
            ),
            Text(
              'Category: ${task.category}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (task.deadline != null)
              Text(
                'Deadline: ${formatDateTime(task.deadline!)}',
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
        trailing: IconButton(
          icon: Icon(
            task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onPressed: onToggleCompletion,
        ),
      ),
    );
  }
}
