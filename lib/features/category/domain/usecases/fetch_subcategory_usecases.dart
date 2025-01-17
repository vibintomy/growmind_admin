import 'package:growmind_admin/features/category/domain/entities/subcategory.dart';
import 'package:growmind_admin/features/category/domain/repository/fetch_subcat_repo.dart';

class GetSubcategory {
  final FetchSubcatRepo fetchSubcatRepo;
  GetSubcategory(this.fetchSubcatRepo);
  Future<List<Subcategory>> call({required String categoryId}) async {
    return fetchSubcatRepo.fetchSubCategory(categoryId: categoryId);
  }

  Future<void> delete(
      {required String categoryId, required String subcategoryId}) async {
    return fetchSubcatRepo.delete(
        categoryId: categoryId, subcategoryId: subcategoryId);
  }

  Future<void> updateData(
      {required String categoryId,
      required String subcategoryId,
      required String name}) async {
  
    return fetchSubcatRepo.updateData(
        categoryId: categoryId, subcategoryId: subcategoryId, name: name);
  }
}
