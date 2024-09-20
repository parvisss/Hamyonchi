import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_state.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_bloc.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_event.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_state.dart';
import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/bloc/expense/expense_state.dart';
import 'package:exam_6/bloc/salary/salary_bloc.dart';
import 'package:exam_6/bloc/salary/salary_event.dart';
import 'package:exam_6/bloc/salary/salary_state.dart';
import 'package:exam_6/ui/widgets/cards_widget.dart';
import 'package:exam_6/ui/widgets/list_builder.dart';
import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(LoadExpense());
    context.read<SalaryBloc>().add(LoadSalary());
    context.read<CalculateExpanseBloc>().add(CalculateExpanse());
    context.read<CalculateIncomeBloc>().add(CalculateIncome());
    super.initState();
  }

  bool isEx = true;
  final categoryController = TextEditingController();
  final summController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hamyonchi"),
          centerTitle: false,
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.notifications_none_outlined))
          // ],
        ),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        child: BlocBuilder<CalculateExpanseBloc,
                            CalculateExpanseState>(
                          builder: (context, state) {
                            if (state is CalculateExpanseLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CalculateExpanseError) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            if (state is CalculateExpanseLoaded) {
                              return InkWell(
                                child: CardWidget(
                                  title: context.tr('Total Expense'),
                                  amount: state.summ,
                                  color: isEx
                                      ? AppColors.colorBlue
                                      : AppColors.colorGrey,
                                  isMain: true,
                                ),
                                onTap: () {
                                  isEx = true;
                                  setState(() {});
                                },
                              );
                            }
                            return InkWell(
                              child: CardWidget(
                                title: context.tr('Total Expense'),
                                amount: '0',
                                color: isEx
                                    ? AppColors.colorBlue
                                    : AppColors.colorGrey,
                                isMain: true,
                              ),
                              onTap: () {
                                isEx = true;
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        child: BlocBuilder<CalculateIncomeBloc,
                            CalculateIncomeState>(
                          builder: (context, state) {
                            if (state is CalculateIncomeLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CalculateIncomeError) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            if (state is CalculateIncomeLoaded) {
                              return InkWell(
                                child: CardWidget(
                                  title: context.tr('Total Salary'),
                                  amount: state.summ,
                                  color: !isEx
                                      ? AppColors.colorBlue
                                      : AppColors.colorGrey,
                                  isMain: true,
                                ),
                                onTap: () {
                                  isEx = false;
                                  setState(() {});
                                },
                              );
                            }
                            return InkWell(
                              child: CardWidget(
                                title: context.tr('Total Salary'),
                                amount: '0',
                                color: !isEx
                                    ? AppColors.colorBlue
                                    : AppColors.colorGrey,
                                isMain: true,
                              ),
                              onTap: () {
                                isEx = false;
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
              ),
            ),

            //! creating elements
            isEx
                ? SliverToBoxAdapter(
                    child: BlocBuilder<ExpenseBloc, ExpenseState>(
                      builder: (context, state) {
                        if (state is ExpenseStateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ExpenseStateError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.message),
                            ),
                          );
                        }
                        if (state is ExpenseStateUploaded) {
                          return SizedBox(
                            child: ListBuilder(
                              state: state,
                              isMain: true,
                              isEx: true,
                            ),
                          );
                        }
                        return Center(child: Text(context.tr('Empty Data')));
                      },
                    ),
                  )
                : SliverToBoxAdapter(
                    child: BlocBuilder<SalaryBloc, SalaryState>(
                      builder: (context, state) {
                        if (state is SalaryStateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SalaryStateError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.message),
                            ),
                          );
                        }
                        if (state is SalaryStateUploaded) {
                          return SizedBox(
                            child: ListBuilder(
                              state: state,
                              isMain: true,
                              isEx: false,
                            ),
                          );
                        }
                        return Center(child: Text(context.tr('Empty Data')));
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
