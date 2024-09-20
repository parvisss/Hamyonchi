import 'package:bloc/bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/bloc/expense/expense_state.dart';
import 'package:exam_6/controller/sql/database_helper.dart';
import 'package:exam_6/data/models/expense.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DatabaseHelper database = DatabaseHelper();

  ExpenseBloc() : super(ExpenseStateinitial()) {
    on<LoadExpense>(_loadExpense);
    on<AddExpense>(_addExpense);
    on<EditExpense>(_editExpense);
    on<DeleteExpense>(_deleteExpense);
  }

  //! Fetch expenses from the database
  Future<void> _loadExpense(
      LoadExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseStateLoading());
    try {
      final List<Expense> expenses = await database.fetchExpenses();
      emit(ExpenseStateUploaded(list: expenses.reversed.toList()));
    } catch (e) {
      emit(ExpenseStateError(message: e.toString()));
    }
  }

  //! Add a new expense to the database
  Future<void> _addExpense(AddExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseStateLoading());
    try {
      await database.insertExpense(event.expense);
      final List<Expense> expenses = await database.fetchExpenses();
      emit(ExpenseStateUploaded(list: expenses.reversed.toList()));
    } catch (e) {
      emit(ExpenseStateError(message: e.toString()));
    }
  }

  //! Edit an existing expense in the database
  Future<void> _editExpense(
      EditExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseStateLoading());
    try {
      await database.updateExpense(event.expense);
      final List<Expense> expenses = await database.fetchExpenses();
      emit(ExpenseStateUploaded(list: expenses.reversed.toList()));
    } catch (e) {
      emit(ExpenseStateError(message: e.toString()));
    }
  }

  //! Delete an expense from the database
  Future<void> _deleteExpense(
      DeleteExpense event, Emitter<ExpenseState> emit) async {
    emit(ExpenseStateLoading());
    try {
      await database.deleteExpense(event.expense.id);
      final List<Expense> expenses = await database.fetchExpenses();
      emit(ExpenseStateUploaded(list: expenses.reversed.toList()));
    } catch (e) {
      emit(ExpenseStateError(message: e.toString()));
    }
  }
}
