import 'package:exam_6/bloc/calculate_expense/calculate_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/bloc/expense/expense_state.dart';
import 'package:exam_6/ui/screens/add_new.dart';
import 'package:exam_6/ui/widgets/cards_widget.dart';
import 'package:exam_6/ui/widgets/list_builder.dart';
import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(LoadExpense());
    context.read<CalculateExpanseBloc>().add(CalculateExpanse());
    super.initState();
  }

  final categoryController = TextEditingController();
  final summController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      child: CardWidget(
                        title: 'Add Expense',
                        color: AppColors.colorBlue,
                        amount: '',
                        isMain: false,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const AddNew(
                                  isEx: true,
                                )),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                        child: CardWidget(
                          title: 'Add Income',
                          amount: '',
                          color: AppColors.colorGrey,
                          isMain: false,
                        ),
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const AddNew(
                                        isEx: false,
                                      )),
                            )),
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
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Latest Entries:",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
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
                return const Center(child: Text('Empty Data'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
