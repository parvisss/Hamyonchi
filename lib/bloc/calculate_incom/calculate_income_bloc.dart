import 'package:exam_6/bloc/calculate_incom/calculate_income_event.dart';
import 'package:exam_6/bloc/calculate_incom/calculate_income_state.dart';
import '../../utils/meneger_sql.dart';
import 'package:exam_6/controller/sql/database_helper_2.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateIncomeBloc
    extends Bloc<CalculateIncomeEvent, CalculateIncomeState> {
  CalculateIncomeBloc() : super(CalculateIncomeInitial()) {
    on<CalculateIncome>(_calculateIn);
  }

  final DatabaseHelper2 databaseIn = DatabaseHelper2(tableName: 'Salary');

  Future<void> _calculateIn(
      CalculateIncome event, Emitter<CalculateIncomeState> emit) async {
    emit(CalculateIncomeLoading());
    try {
      final List<Expense> expenses = await databaseIn.fetchExpenses();
      final sum = await MenegerSql().calculateTotalExpense(expenses);
      emit(CalculateIncomeLoaded(summ: sum.toString()));
    } catch (e) {
      emit(CalculateIncomeError(message: e.toString()));
    }
  }
}
