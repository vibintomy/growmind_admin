abstract class FetchSubcategoryEvent {}

class GetSubcategoryEvent extends FetchSubcategoryEvent {
  final String categoryId;
  GetSubcategoryEvent({required this.categoryId});
}

class DeleteSubcategoryEvent extends FetchSubcategoryEvent {
  final String subcategoryId;
  final String categoryId;
  DeleteSubcategoryEvent(
      {required this.categoryId, required this.subcategoryId});
}

class UpdateSubcategoryEvent extends FetchSubcategoryEvent {
  final String subcategoryId;
  final String categoryId;
  final String name;
  UpdateSubcategoryEvent(
      {required this.categoryId,
      required this.subcategoryId,
      required this.name});
}
