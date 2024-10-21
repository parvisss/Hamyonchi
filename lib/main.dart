import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/bloc/cahrt_expanse/chart_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_bloc.dart';
import 'package:exam_6/bloc/chart_income/chart_income_bloc.dart';
import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense_category/expense_category_bloc.dart';
import 'package:exam_6/bloc/salary/salary_bloc.dart';
import 'package:exam_6/bloc/salary_category/salary_category_bloc.dart';
import 'package:exam_6/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('uz'),
      ],
      fallbackLocale: const Locale('uz'),
      path: 'assets/translations',
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ExpenseBloc()),
        BlocProvider(create: (context) => CalculateExpanseBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => SalaryBloc()),
        BlocProvider(create: (context) => CalculateIncomeBloc()),
        BlocProvider(create: (context) => SalaryCategoryBloc()),
        BlocProvider(create: (context) => ChartExpanseBloc()),  
        BlocProvider(create: (context) => ChartIncomeBloc()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
