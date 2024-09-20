sealed class CategoryEvent {}

final class AddCategoryExEvent extends CategoryEvent {
  String category;
  AddCategoryExEvent({required this.category});
}

final class GetAllCategoryExEvent extends CategoryEvent {}
