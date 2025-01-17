abstract class SubcategoryEvent {}

class SubmitCategoryEvent extends SubcategoryEvent {
  final String name;
  final String categoryId;

  SubmitCategoryEvent({required this.name, required this.categoryId});
}
