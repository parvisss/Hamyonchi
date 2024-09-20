import 'package:exam_6/bloc/cahrt_expanse/chart_expanse_event.dart';
import 'package:exam_6/bloc/cahrt_expanse/chart_expanse_state.dart';
import 'package:exam_6/controller/sql/database_helper.dart';
import 'package:exam_6/data/models/cahrt_data.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:exam_6/utils/meneger_sql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartExpanseBloc extends Bloc<ChartExpanseEvent, ChartExpanseState> {
  ChartExpanseBloc() : super(InitialChartExpanseState()) {
    on<CalculateChartExpanseEvent>(_onCalculate);
  }

  Future<void> _onCalculate(
      CalculateChartExpanseEvent event, Emitter<ChartExpanseState> emit) async {
    emit(LoadingChartExpanseState());
    try {
      final List<Expense> list = await DatabaseHelper().fetchExpenses();
      final List<ChartData> cahrtData = await MenegerSql().totalExValue(list);
      emit(LoadedChartExpanseState(list: cahrtData));
    } catch (e) {
      emit(ErrorChartExpanseState(message: e.toString()));
    }
  }
}
