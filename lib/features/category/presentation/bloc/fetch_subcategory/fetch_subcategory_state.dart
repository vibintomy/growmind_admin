import 'package:growmind_admin/features/category/domain/entities/subcategory.dart';

abstract class FetchSubcategoryState {}

class FetchSubcategoryInitial extends FetchSubcategoryState {}

class FetchSubcategoryLoading extends FetchSubcategoryState {}

class FetchSubcategoryLoaded extends FetchSubcategoryState {
  final List<Subcategory> fetchSubcategory;
  FetchSubcategoryLoaded(this.fetchSubcategory);
}

class FetchSubcategoryError extends FetchSubcategoryState {
  final String error;
  FetchSubcategoryError(this.error);
}
