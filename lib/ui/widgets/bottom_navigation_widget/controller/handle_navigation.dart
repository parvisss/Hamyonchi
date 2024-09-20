import 'package:exam_6/ui/screens/calendar/calendar_screen.dart';
import 'package:exam_6/ui/screens/charts/screen/chart_screen.dart';
import 'package:exam_6/ui/screens/home/ui/screen/home_screen.dart';
import 'package:exam_6/ui/screens/settings/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';

handleNavigation(int index, BuildContext context) {
  switch (index) {
    case 0:
      const HomeScreen();
      break;
    case 1:
      const ChartScreen();
      break;
    case 2:
      CalendarScreen();
      break;
    case 3:
      const SettingsScreen();
      break;
  }
}
