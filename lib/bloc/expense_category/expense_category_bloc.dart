import 'package:exam_6/bloc/expense_category/expense_category_event.dart';
import 'package:exam_6/bloc/expense_category/expense_category_state.dart';
import '../../utils/meneger_sql.dart';
import 'package:exam_6/controller/sql/database_helper.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryStateInitial()) {
    on<GetAllCategoryExEvent>(_onGetExpenseCategoryEvent);
  }
  Future<void> _onGetExpenseCategoryEvent(
      GetAllCategoryExEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoading());
    try {
      final DatabaseHelper database = DatabaseHelper();
      final List<Expense> expenses = await database.fetchExpenses();
      final categories = await MenegerSql().getCategories(expenses);
      emit(CategoryExStateLoaded(categories: categories));
    } catch (e) {
      emit(CategoryStateError(message: e.toString()));
    }
  }
}
