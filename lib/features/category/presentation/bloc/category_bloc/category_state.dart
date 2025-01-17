abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class ImageUpLoading extends CategoryState {}

class ImageUploaded extends CategoryState {
  final String imageUrl;
  ImageUploaded(this.imageUrl);
}

class CategorySubmitting extends CategoryState {}

class CategorySucess extends CategoryState {}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
