import 'package:exam_6/bloc/calculate_expense/calculate_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_bloc.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_event.dart';
import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/bloc/salary/salary_bloc.dart';
import 'package:exam_6/bloc/salary/salary_event.dart';
import 'package:exam_6/ui/widgets/bottom_navigation_widget/controller/handle_navigation.dart';
import 'package:exam_6/ui/widgets/bottom_navigation_widget/ui/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(LoadExpense());
    context.read<SalaryBloc>().add(LoadSalary());
    context.read<CalculateExpanseBloc>().add(CalculateExpanse());
    context.read<CalculateIncomeBloc>().add(CalculateIncome());
    super.initState();
  }

  int currentIndex = 0;

  bool isEx = true;
  final categoryController = TextEditingController();
  final summController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: handleNavigation(currentIndex, context),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
