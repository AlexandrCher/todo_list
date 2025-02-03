import 'package:flutter/material.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/widgets/task_card.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = [
    Task(title: 'Task 1', deadline: DateTime.now().add(Duration(days: 1))),
    Task(title: 'Task 2', deadline: DateTime.now().add(Duration(days: 2))),
    Task(title: 'Task 3', deadline: DateTime.now().add(Duration(days: 3))),
  ];
  final TextEditingController _controller = TextEditingController();

  void _addTask(String title, DateTime deadline) {
    setState(() {
      _tasks.add(Task(title: title, deadline: deadline));
    });
    _controller.clear();
  }

  Future<DateTime?> _selectDeadline(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        return DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
      }
    }
    return null;
  }

  void _showAddTaskDialog() async {
    final DateTime? deadline = await _selectDeadline(context);
    if (deadline != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Task'),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _addTask(_controller.text, deadline);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      if (_tasks[index].isCompleted) {
        _tasks[index].completionDate = DateTime.now();
      } else {
        _tasks[index].completionDate = null;
      }
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'New Task',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showAddTaskDialog,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return TaskCard(
                  task: task,
                  onToggleCompletion: () => _toggleTaskCompletion(index),
                  onDelete: () => _removeTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}