sealed class CalculateIncomeState {}

final class CalculateIncomeInitial extends CalculateIncomeState {}

final class CalculateIncomeLoading extends CalculateIncomeState {}

final class CalculateIncomeLoaded extends CalculateIncomeState {
  String summ;
  CalculateIncomeLoaded({required this.summ});
}

final class CalculateIncomeError extends CalculateIncomeState {
  String message;
  CalculateIncomeError({required this.message});
}
