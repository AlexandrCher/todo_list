import 'package:flutter/material.dart';
import 'package:todo_list/helpers/format_datetime.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/screens/statistics_screen.dart';
import 'package:todo_list/widgets/task_card.dart';

import '../model/destination.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = [
    Task(
        title: 'Task 1',
        deadline: DateTime.now().add(Duration(days: 1)),
        category: 'Work'),
    Task(title: 'Task 2', category: 'Shopping'),
    Task(
        title: 'Task 3',
        deadline: DateTime.now().add(Duration(days: 3)),
        category: 'Meetings'),
    Task(title: 'Task 4', category: 'Learning'),
  ];
  final TextEditingController _controller = TextEditingController();
  String _selectedCategory = 'Work';
  final List<String> _categories = ['Work', 'Shopping', 'Meetings', 'Learning'];
  String _selectedFilterCategory = 'All';
  int currentScreenIndex = 0;

  void _addTask(String title, DateTime? deadline, String category) {
    setState(() {
      _tasks.add(Task(title: title, deadline: deadline, category: category));
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
        return DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
            pickedTime.hour, pickedTime.minute);
      }
    }
    return null;
  }

  void _updateTask(
      int index, String title, DateTime? deadline, String category) {
    setState(() {
      _tasks[index] = Task(
        title: title,
        deadline: deadline,
        category: category,
        isCompleted: _tasks[index].isCompleted,
        completionDate: _tasks[index].completionDate,
      );
    });
  }

  void _showAddTaskDialog({Task? task, int? index}) async {
    DateTime? deadline = task?.deadline;
    _controller.text = task?.title ?? '';
    String localSelectedCategory = task?.category ?? _selectedCategory;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task == null ? 'New Task' : 'Edit Task'),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(labelText: 'Task Title'),
                    ),
                    DropdownButton<String>(
                      value: localSelectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          localSelectedCategory = newValue!;
                        });
                      },
                      items: _categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        Text(deadline != null
                            ? 'Deadline: ${formatDateTime(deadline!)}'
                            : 'No Deadline'),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? newDeadline =
                                await _selectDeadline(context);
                            setState(() {
                              deadline = newDeadline;
                            });
                          },
                        ),
                        if (deadline != null)
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                deadline = null;
                              });
                            },
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  if (task == null) {
                    _addTask(_controller.text, deadline, localSelectedCategory);
                  } else {
                    _updateTask(index!, _controller.text, deadline,
                        localSelectedCategory);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(task == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
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

  void _editTask(int index) {
    _showAddTaskDialog(task: _tasks[index], index: index);
  }

  List<Task> _getSortedTasks() {
    List<Task> sortedTasks = List.from(_tasks);
    sortedTasks.sort((a, b) {
      if (a.deadline != null && b.deadline != null) {
        return a.deadline!.compareTo(b.deadline!);
      } else if (a.deadline != null) {
        return -1;
      } else if (b.deadline != null) {
        return 1;
      } else {
        return a.title.compareTo(b.title);
      }
    });
    return sortedTasks;
  }

  void updateCurrentPageIndex(int newIndex) {
    setState(() {
      currentScreenIndex = newIndex;
    });
  }

  List<Destination> get destinations {
    return [
      Destination(
        screenTitle: Text('TODO List'),
        navLabel: 'TODO List',
        navIcon: Icons.receipt_long_outlined,
        navSelectedIcon: Icons.receipt_long,
        appBarActions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.add),
          ),
        ],
        screen: Column(
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
                itemCount: _getSortedTasks().length,
                itemBuilder: (context, index) {
                  final task = _getSortedTasks()[index];
                  if (_selectedFilterCategory == 'All' ||
                      task.category == _selectedFilterCategory) {
                    return TaskCard(
                      task: task,
                      onToggleCompletion: () => _toggleTaskCompletion(index),
                      onDelete: () => _removeTask(index),
                      onEdit: () => _editTask(index),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      Destination(
        screenTitle: Text('Statistics'),
        navLabel: 'Statistics',
        navIcon: Icons.pie_chart_outline,
        navSelectedIcon: Icons.pie_chart,
        screen: StatisticsScreen(tasks: _tasks),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final destination = destinations[currentScreenIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        actions: [
          DropdownButton<String>(
            value: _selectedFilterCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilterCategory = newValue!;
              });
            },
            items: ['All', ..._categories]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreenIndex,
        onDestinationSelected: updateCurrentPageIndex,
        destinations: destinations
            .map((destination) => NavigationDestination(
                icon: Icon(destination.navIcon),
                selectedIcon: Icon(destination.navSelectedIcon),
                label: destination.navLabel))
            .toList(),
      ),
      body: destination.screen,
    );
  }
}
