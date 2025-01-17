abstract class SubcategoryState {}

class SubCategoryInitial extends SubcategoryState {}

class SubCategorySubmitting extends SubcategoryState {}

class SubCategorySuccess extends SubcategoryState {}

class SubCategoryError extends SubcategoryState {
  final String error;
  SubCategoryError(this.error);
}
