import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/bloc/expense_category/expense_category_bloc.dart';
import 'package:exam_6/bloc/expense_category/expense_category_event.dart';
import 'package:exam_6/bloc/expense_category/expense_category_state.dart';
import 'package:exam_6/bloc/salary/salary_bloc.dart';
import 'package:exam_6/bloc/salary/salary_event.dart';
import 'package:exam_6/bloc/salary_category/salary_category_bloc.dart';
import 'package:exam_6/bloc/salary_category/salary_category_event.dart';
import 'package:exam_6/bloc/salary_category/salary_category_state.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:exam_6/ui/widgets/category_builder.dart';
import 'package:exam_6/ui/widgets/special/main_button.dart';
import 'package:exam_6/ui/widgets/special/text_field_widget.dart';
import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key, this.expense, this.isEx});
  final Expense? expense;
  final bool? isEx;
  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final summController = TextEditingController();

  final descriptionController = TextEditingController();
  String selectedCategory = 'Other';
  int? selectedChip;
  DateTime _date = DateTime.now();
  @override
  void initState() {
    if (widget.expense != null) {
      summController.text = widget.expense!.summ;
      descriptionController.text = widget.expense!.comment;
      selectedCategory = widget.expense!.category;
      _date = DateTime.parse(widget.expense!.date);
    }

    context.read<CategoryBloc>().add(GetAllCategoryExEvent());
    context.read<SalaryCategoryBloc>().add(GetAllCategoryInEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense != null
            ? "Edit"
            : widget.isEx!
                ? "Add Expense"
                : "Add Income"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: CalendarDatePicker(
                  initialDate: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                  onDateChanged: (date) {
                    _date = date;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorGrey,
                    ),
                  ),
                ),
                subtitle: TextFieldWidget(
                  keyboard: TextInputType.text, // Corrected typo
                  controller: descriptionController,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Amount",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorGrey,
                    ),
                  ),
                ),
                subtitle: TextFieldWidget(
                  keyboard: TextInputType.number, // Corrected typo
                  controller: summController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.isEx!
                  ? SizedBox(
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryStateLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is CategoryStateError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.message),
                              ),
                            );
                          }
                          if (state is CategoryExStateLoaded) {
                            return SizedBox(
                              child: CategoryBuilder(
                                state: state,
                                selectedCategory: selectedCategory,
                                selectedChip: selectedChip,
                                onCategorySelected: (String category) {
                                  selectedCategory = category;
                                },
                              ),
                            );
                          }
                          return const Text("No categories");
                        },
                      ),
                    )
                  : SizedBox(
                      child:
                          BlocBuilder<SalaryCategoryBloc, SalaryCategoryState>(
                        builder: (context, state) {
                          if (state is CategoryInStateLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is CategoryInStateError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.message),
                              ),
                            );
                          }
                          if (state is CategoryInStateLoaded) {
                            return SizedBox(
                              child: CategoryBuilder(
                                state: state,
                                selectedCategory: selectedCategory,
                                selectedChip: selectedChip,
                                onCategorySelected: (String category) {
                                  selectedCategory = category;
                                },
                              ),
                            );
                          }
                          return const Text("No categories");
                        },
                      ),
                    ),
              const SizedBox(height: 80)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: MainButton(
          title: widget.expense == null ? "Add" : "Save",
          function: () {
            widget.expense != null
                ? context.read<ExpenseBloc>().add(
                      EditExpense(
                        expense: Expense(
                            id: widget.expense!.id,
                            category: selectedCategory,
                            summ: summController.text,
                            date: _date.toString(),
                            comment: descriptionController.text),
                      ),
                    )
                : widget.isEx!
                    ? context.read<ExpenseBloc>().add(
                          AddExpense(
                            expense: Expense(
                                id: UniqueKey().toString(),
                                category: selectedCategory,
                                summ: summController.text,
                                date: _date.toString(),
                                comment: descriptionController.text),
                          ),
                        )
                    : context.read<SalaryBloc>().add(
                          AddSalary(
                            salary: Expense(
                                id: UniqueKey().toString(),
                                category: selectedCategory,
                                summ: summController.text,
                                date: _date.toString(),
                                comment: descriptionController.text),
                          ),
                        );

            summController.text = '';
            descriptionController.text = '';
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
