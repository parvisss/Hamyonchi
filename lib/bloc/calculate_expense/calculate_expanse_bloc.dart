import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_state.dart';
import '../../utils/meneger_sql.dart';
import 'package:exam_6/controller/sql/database_helper_2.dart';
import 'package:exam_6/controller/sql/database_helper.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateExpanseBloc
    extends Bloc<CalculateExpanseEvent, CalculateExpanseState> {
  CalculateExpanseBloc() : super(CalculateExpanseInitial()) {
    on<CalculateExpanse>(_calculate);
  }

  final DatabaseHelper databaseEx = DatabaseHelper();
  final DatabaseHelper2 databaseIn = DatabaseHelper2(tableName: 'Salary');

  Future<void> _calculate(
      CalculateExpanse event, Emitter<CalculateExpanseState> emit) async {
    emit(CalculateExpanseLoading());
    try {
      final List<Expense> expenses = await databaseEx.fetchExpenses();
      final sum = await MenegerSql().calculateTotalExpense(expenses);
      emit(CalculateExpanseLoaded(summ: sum.toString()));
    } catch (e) {
      emit(CalculateExpanseError(message: e.toString()));
    }
  }
}
