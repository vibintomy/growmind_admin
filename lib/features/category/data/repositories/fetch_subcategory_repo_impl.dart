import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/category/data/datasource/subcategory_remote_datasource.dart';
import 'package:growmind_admin/features/category/domain/entities/subcategory.dart';
import 'package:growmind_admin/features/category/domain/repository/fetch_subcat_repo.dart';

class FetchSubcategoryRepoImpl extends FetchSubcatRepo {
  final SubcategoryRemoteDatasource subcategoryRemoteDatasource;
  final FirebaseFirestore firestore;
  FetchSubcategoryRepoImpl(this.subcategoryRemoteDatasource, this.firestore);

  @override
  Future<List<Subcategory>> fetchSubCategory(
      {required String categoryId}) async {
    final subCategoryModel = await subcategoryRemoteDatasource.fetchSubCategory(
        categoryId: categoryId);
    if (subCategoryModel == null) {
      throw Exception('No data is fetched ');
    }
    return subCategoryModel.map((docs) {
      return Subcategory(id: docs.id, name: docs.name);
    }).toList();
  }

  @override
  Future<void> delete(
      {required String categoryId, required String subcategoryId}) async {
    final subcategory =
        await subcategoryRemoteDatasource.delete(categoryId, subcategoryId);
    return subcategory;
  }

  @override
  Future<void> updateData(
      {required String categoryId,
      required String subcategoryId,
      required String name}) async {
    final subcategory = await subcategoryRemoteDatasource.updateData(
        categoryId: categoryId, subcategoryId: subcategoryId, name: name);
    return subcategory;
  }
}
