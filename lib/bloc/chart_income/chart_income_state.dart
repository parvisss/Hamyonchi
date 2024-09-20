import 'package:exam_6/data/models/cahrt_data.dart';

sealed class ChartIncomeState {}

final class InitialChartIncomeState extends ChartIncomeState {}

final class LoadingChartIncomeState extends ChartIncomeState {}

final class LoadedChartIncomeState extends ChartIncomeState {
  final List<ChartData> list;
  LoadedChartIncomeState({required this.list});
}

final class ErrorChartIncomeState extends ChartIncomeState {
  final String message;
  ErrorChartIncomeState({required this.message});
}
