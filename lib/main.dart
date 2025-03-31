import 'package:flutter/material.dart';
import 'package:todo_list/screens/todo_list_screen.dart';
import 'package:todo_list/theme/dark_theme.dart';
import 'package:todo_list/theme/light_theme.dart';

void main() {
  runApp(MaterialApp(
    theme: lightTheme,
    darkTheme: darkTheme,
    home: TodoListScreen(),
  ));
}