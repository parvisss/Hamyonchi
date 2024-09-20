sealed class CategoryState {}

final class CategoryStateInitial extends CategoryState {}

final class CategoryStateLoading extends CategoryState {}

final class CategoryExStateLoaded extends CategoryState {
  List<String> categories;
  CategoryExStateLoaded({required this.categories});
}

final class CategoryStateError extends CategoryState {
  String message;
  CategoryStateError({required this.message});
}
