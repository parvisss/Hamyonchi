import 'package:easy_localization/easy_localization.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_bloc.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_event.dart';
import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/bloc/salary/salary_bloc.dart';
import 'package:exam_6/bloc/salary/salary_event.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:exam_6/ui/screens/add/add_new.dart';
import 'package:exam_6/ui/widgets/dialogs/default_dialog.dart';
import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBuilder extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final bool isMain;
  final bool isEx;
  final dynamic state;
  ListBuilder(
      {super.key,
      required this.state,
      required this.isMain,
      required this.isEx});
  final categoryController = TextEditingController();
  final summController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: isMain
          ? state.list.length
          : state.list.length >= 3
              ? 3
              : state.list.length,
      itemBuilder: (ctx, index) {
        Expense expense = state.list[index];
        return InkWell(
          child: ListTile(
            title: Text(
              expense.category,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
                "${DateTime.parse(expense.date).day}-${DateTime.parse(expense.date).month}-${DateTime.parse(expense.date).year}"),
            trailing: isEx
                ? Text(
                    "-\$${expense.summ}",
                    style: TextStyle(fontSize: 22, color: AppColors.coloRred),
                  )
                : Text(
                    "+\$${expense.summ}",
                    style:
                        TextStyle(fontSize: 22, color: AppColors.colorsGreen),
                  ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return DefaultDialog(content: expense.comment);
                });
          },
          //! editing and dleting
          onLongPress: () {
            summController.text = expense.summ;
            descriptionController.text = expense.comment;
            categoryController.text = expense.category;
            showDialog(
              context: context,
              builder: (ctx) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => AddNew(
                                expense: expense,
                                isEx: isEx,
                              ),
                            ),
                          );
                        },
                        child:  Text("Edit".tr()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                        onPressed: () async {
                          isEx
                              ? context
                                  .read<ExpenseBloc>()
                                  .add(DeleteExpense(expense: expense))
                              : context
                                  .read<SalaryBloc>()
                                  .add(DeleteSalary(salary: expense));
                          Navigator.pop(context);
                          context
                              .read<CalculateExpanseBloc>()
                              .add(CalculateExpanse());
                          context
                              .read<CalculateIncomeBloc>()
                              .add(CalculateIncome());
                        },
                        child:  Text('Delete'.tr()),
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
