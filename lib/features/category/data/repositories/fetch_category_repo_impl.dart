import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/category/data/datasource/category_remote_datasource.dart';
import 'package:growmind_admin/features/category/domain/entities/category.dart';
import 'package:growmind_admin/features/category/domain/repository/fetch_cat_repo.dart';

class FetchCategoryRepoImpl extends FetchCatRepo {
  final CategoryRemoteDatasource remoteDatasource;
  final FirebaseFirestore firestore;
  FetchCategoryRepoImpl(this.remoteDatasource, this.firestore);

  @override
  Future<List<FetchCategory>> fetchcategory() async {
    final categoryModel = await remoteDatasource.fetchCategory();

    if (categoryModel == null) {
      throw Exception('No data found');
    }
    return categoryModel.map((model) {
      return FetchCategory(
          id: model.id, category: model.category.toString(), imageUrl: model.imageUrl.toString());
    }).toList();
  }
}
