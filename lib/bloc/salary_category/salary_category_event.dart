sealed class SalaryCategoryEvent {}

final class AddCategoryInEvent extends SalaryCategoryEvent {
  String category;
  AddCategoryInEvent({required this.category});
}

final class GetAllCategoryInEvent extends SalaryCategoryEvent {}
