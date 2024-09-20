import 'package:exam_6/bloc/salary_category/salary_category_event.dart';
import 'package:exam_6/bloc/salary_category/salary_category_state.dart';
import '../../utils/meneger_sql.dart';
import 'package:exam_6/controller/sql/database_helper_2.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalaryCategoryBloc
    extends Bloc<SalaryCategoryEvent, SalaryCategoryState> {
  SalaryCategoryBloc() : super(CategoryInStateInitial()) {
    on<GetAllCategoryInEvent>(_onGetIncomeCategoryEvent);
  }

  Future<void> _onGetIncomeCategoryEvent(
      GetAllCategoryInEvent event, Emitter<SalaryCategoryState> emit) async {
    emit(CategoryInStateLoading());
    try {
      final DatabaseHelper2 database = DatabaseHelper2(tableName: 'Salary');
      final List<Expense> expenses = await database.fetchExpenses();
      final categories = await MenegerSql().getCategories(expenses);
      emit(CategoryInStateLoaded(categories: categories));
    } catch (e) {
      emit(CategoryInStateError(message: e.toString()));
    }
  }
}
