import 'package:exam_6/data/models/expense.dart';

final class SalaryState {}

final class SalaryStateinitial extends SalaryState {}

final class SalaryStateLoading extends SalaryState {}

final class SalaryStateLoaded extends SalaryState {}

final class SalaryStateUploaded extends SalaryState {
  List<Expense> list;
  SalaryStateUploaded({required this.list});
}

final class SalaryStateError extends SalaryState {
  String message;
  SalaryStateError({required this.message});
}
