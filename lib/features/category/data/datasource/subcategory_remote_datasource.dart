import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/category/data/model/fetch_subcategory_model.dart';
import 'package:growmind_admin/features/category/domain/entities/subcategory.dart';

class SubcategoryRemoteDatasource {
  final FirebaseFirestore firestore;
  SubcategoryRemoteDatasource(this.firestore);
  Future<List<FetchSubcategoryModel>> fetchSubCategory(
      {required String categoryId}) async {
    try {
      final snapshot = await firestore.collection('category').doc(categoryId);

      final subCategorySnapshot =
          await snapshot.collection('subcategory').get();

      if (subCategorySnapshot.docs.isEmpty) {
        throw Exception('No subcategories found');
      }
      return subCategorySnapshot.docs.map((docs) {
        final data = docs.data();
        return FetchSubcategoryModel.fromFirestore({...data, 'id': docs.id});
      }).toList();
    } catch (e) {
      throw Exception('No value found');
    }
  }

  Future<void> delete(String CategoryId, String subcategoryId) async {
    try {
      await firestore
          .collection('category')
          .doc(CategoryId)
          .collection('subcategory')
          .doc(subcategoryId)
          .delete();
    } catch (e) {
      throw Exception('No data is deleted');
    }
  }

  Future<void> updateData({
    required categoryId,
    required subcategoryId,
    required String name,
  }) async {
    try {
      await firestore
          .collection('category')
          .doc(categoryId)
          .collection('subcategory')
          .doc(subcategoryId)
          .update({'name': name});
    } catch (e) {
      throw Exception('Error in updating data');
    }
  }
}
