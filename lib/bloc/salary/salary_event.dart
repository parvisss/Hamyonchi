import 'package:exam_6/data/models/expense.dart';

final class SalaryEvent {}

final class AddSalary extends SalaryEvent {
  final Expense salary;
  AddSalary({required this.salary});
}

final class EditSalary extends SalaryEvent {
  final Expense salary;
  EditSalary({required this.salary});
}

final class LoadSalary extends SalaryEvent {}

final class DeleteSalary extends SalaryEvent {
  Expense salary;
  DeleteSalary({required this.salary});
}
