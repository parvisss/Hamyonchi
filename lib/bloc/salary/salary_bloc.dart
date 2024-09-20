import 'package:bloc/bloc.dart';
import 'package:exam_6/bloc/salary/salary_event.dart';
import 'package:exam_6/bloc/salary/salary_state.dart';
import 'package:exam_6/controller/sql/database_helper_2.dart';
import 'package:exam_6/data/models/expense.dart';

class SalaryBloc extends Bloc<SalaryEvent, SalaryState> {
  final DatabaseHelper2 database = DatabaseHelper2(tableName: 'Salary');

  SalaryBloc() : super(SalaryStateinitial()) {
    on<LoadSalary>(_loadSalary);
    on<AddSalary>(_addSalary);
    on<EditSalary>(_editSalary);
    on<DeleteSalary>(_deleteSalary);
  }

  //! Fetch Salarys from the database
  Future<void> _loadSalary(LoadSalary event, Emitter<SalaryState> emit) async {
    emit(SalaryStateLoading());
    try {
      final List<Expense> salarys = await database.fetchExpenses();
      emit(SalaryStateUploaded(list: salarys.reversed.toList()));
    } catch (e) {
      emit(SalaryStateError(message: e.toString()));
    }
  }

  //! Add a new Salary to the database
  Future<void> _addSalary(AddSalary event, Emitter<SalaryState> emit) async {
    emit(SalaryStateLoading());
    try {
      await database.insertExpense(event.salary);
      final List<Expense> salarys = await database.fetchExpenses();
      emit(SalaryStateUploaded(list: salarys.reversed.toList()));
    } catch (e) {
      emit(SalaryStateError(message: e.toString()));
    }
  }

  //! Edit an existing Salary in the database
  Future<void> _editSalary(EditSalary event, Emitter<SalaryState> emit) async {
    emit(SalaryStateLoading());
    try {
      await database.updateExpense(event.salary);
      final List<Expense> salarys = await database.fetchExpenses();
      emit(SalaryStateUploaded(list: salarys.reversed.toList()));
    } catch (e) {
      emit(SalaryStateError(message: e.toString()));
    }
  }

  //! Delete an Salary from the database
  Future<void> _deleteSalary(
      DeleteSalary event, Emitter<SalaryState> emit) async {
    emit(SalaryStateLoading());
    try {
      await database.deleteExpense(event.salary.id);
      final List<Expense> salarys = await database.fetchExpenses();
      emit(SalaryStateUploaded(list: salarys.reversed.toList()));
    } catch (e) {
      emit(SalaryStateError(message: e.toString()));
    }
  }
}
