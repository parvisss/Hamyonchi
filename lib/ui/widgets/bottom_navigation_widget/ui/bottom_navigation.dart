import 'package:exam_6/ui/screens/add/add_screen.dart';
import 'package:exam_6/ui/screens/calendar/calendar_screen.dart';
import 'package:exam_6/ui/screens/charts/screen/chart_screen.dart';
import 'package:exam_6/ui/screens/home/ui/screen/home_screen.dart';
import 'package:exam_6/ui/screens/settings/ui/screens/settings_screen.dart';
import 'package:exam_6/ui/widgets/special/add_button.dart';
import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: current,
        children: [
          const HomeScreen(),
          const ChartScreen(),
          CalendarScreen(),
          const SettingsScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        child: const AddButton(),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const AddScreen()));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/svgs/bottom_navigation/home.svg',
                color: current == 0
                    ? AppColors.primaryColor1
                    : AppColors
                        .colorGreyMain, // Change color based on selection
              ),
              onPressed: () {
                setState(() {
                  current = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.pie_chart_outline,
                color: current == 1
                    ? AppColors.primaryColor1
                    : AppColors
                        .colorGreyMain, // Change color based on selection
              ),
              onPressed: () {
                setState(() {
                  current = 1;
                });
              },
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.calendar_month,
                color: current == 2
                    ? AppColors.primaryColor1
                    : AppColors
                        .colorGreyMain, // Change color based on selection
              ),
              onPressed: () {
                setState(() {
                  current = 2;
                });
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/svgs/bottom_navigation/settings.svg',
                color: current == 3
                    ? AppColors.primaryColor1
                    : AppColors
                        .colorGreyMain, // Change color based on selection
              ),
              onPressed: () {
                setState(() {
                  current = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
