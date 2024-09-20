sealed class SalaryCategoryState {}

final class CategoryInStateInitial extends SalaryCategoryState {}

final class CategoryInStateLoading extends SalaryCategoryState {}

final class CategoryInStateLoaded extends SalaryCategoryState {
  List<String> categories;
  CategoryInStateLoaded({required this.categories});
}

final class CategoryInStateError extends SalaryCategoryState {
  String message;
  CategoryInStateError({required this.message});
}
