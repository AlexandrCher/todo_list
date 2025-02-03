import 'package:flutter/material.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/widgets/task_card.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = [
    Task(title: 'Task 1'),
    Task(title: 'Task 2'),
    Task(title: 'Task 3'),
  ];
  final TextEditingController _controller = TextEditingController();

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(title: title));
    });
    _controller.clear();
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
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
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addTask(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child:
            ListView.builder(
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