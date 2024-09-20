import 'package:exam_6/bloc/calculate_expense/calculate_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowDialogWidget extends StatelessWidget {
  final bool isAdd;
  final Expense? expense;
  ShowDialogWidget({super.key, required this.isAdd, this.expense});
  final categoryController = TextEditingController();
  final summController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!isAdd) {
      categoryController.text = expense!.category;
      summController.text = expense!.summ;
      descriptionController.text = expense!.comment;
    }
    return AlertDialog(
      title: const Text('add expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: const TextInputType.numberWithOptions(),
            controller: summController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Summ',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Description',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Category',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              const SizedBox(
                width: 10,
              ),
              FilledButton(
                onPressed: () async {
                  if (descriptionController.text.isNotEmpty &&
                      summController.text.isNotEmpty &&
                      categoryController.text.isNotEmpty) {
                    isAdd
                        ? context.read<ExpenseBloc>().add(
                              AddExpense(
                                expense: Expense(
                                    id: UniqueKey().toString(),
                                    category: categoryController.text,
                                    summ: summController.text,
                                    date:
                                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}",
                                    comment: descriptionController.text),
                              ),
                            )
                        : context.read<ExpenseBloc>().add(
                              EditExpense(
                                expense: Expense(
                                    id: expense!.id,
                                    category: categoryController.text,
                                    summ: summController.text,
                                    date: expense!.date,
                                    comment: descriptionController.text),
                              ),
                            );
                  }
                  Navigator.pop(context);
                  !isAdd ? Navigator.pop(context) : null;

                  context.read<CalculateExpanseBloc>().add(CalculateExpanse());
                  summController.text = '';
                  descriptionController.text = '';
                  categoryController.text = '';
                },
                child: Text(isAdd ? 'Add' : 'Save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
