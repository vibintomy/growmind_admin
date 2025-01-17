import 'package:growmind_admin/features/category/domain/entities/category.dart';

abstract class FetchCategoryState {}

class FetchCategoryInitial extends FetchCategoryState {}

class FetchCategoryLoading extends FetchCategoryState {}

class FetchCategoryLoaded extends FetchCategoryState {
  final List<FetchCategory> fetchCategory;
  FetchCategoryLoaded(this.fetchCategory);
}

class FetchCategoryError extends FetchCategoryState {
  final String message;
  FetchCategoryError(this.message);
}
