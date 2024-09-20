import 'package:exam_6/bloc/chart_income/chart_income_event.dart';
import 'package:exam_6/bloc/chart_income/chart_income_state.dart';
import 'package:exam_6/controller/sql/database_helper_2.dart';
import 'package:exam_6/data/models/cahrt_data.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:exam_6/utils/meneger_sql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartIncomeBloc extends Bloc<ChartIncomeEvent, ChartIncomeState> {
  ChartIncomeBloc() : super(InitialChartIncomeState()) {
    on<CalculateChartIncomeEvent>(_onCalculate);
  }

  Future<void> _onCalculate(
      CalculateChartIncomeEvent event, Emitter<ChartIncomeState> emit) async {
    emit(LoadingChartIncomeState());
    try {
      final List<Expense> list =
          await DatabaseHelper2(tableName: 'Salary').fetchExpenses();
      final List<ChartData> chartData = await MenegerSql().totalExValue(list);
      emit(LoadedChartIncomeState(list: chartData));
    } catch (e) {
      emit(ErrorChartIncomeState(message: e.toString()));
    }
  }
}
