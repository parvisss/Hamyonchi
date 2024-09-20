import 'package:exam_6/data/models/cahrt_data.dart';

sealed class ChartExpanseState {}

final class InitialChartExpanseState extends ChartExpanseState {}

final class LoadingChartExpanseState extends ChartExpanseState {}

final class LoadedChartExpanseState extends ChartExpanseState {
  final List<ChartData> list;
  LoadedChartExpanseState({required this.list});
}

final class ErrorChartExpanseState extends ChartExpanseState {
  final String message;
  ErrorChartExpanseState({required this.message});
}
