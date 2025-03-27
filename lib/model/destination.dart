import 'package:flutter/material.dart';

class Destination {
  final Widget screenTitle;
  final String navLabel;
  final IconData navIcon;
  final IconData? navSelectedIcon;
  final List<Widget>? appBarActions;
  final Widget screen;

  Destination({
    required this.screenTitle,
    required this.navLabel,
    required this.navIcon,
    this.navSelectedIcon,
    this.appBarActions,
    required this.screen,
  });
}
