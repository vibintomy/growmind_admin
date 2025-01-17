import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/category/domain/repository/subcategory_repo.dart';

class SubcatgorRepImpl extends SubcategoryRepo {
  final FirebaseFirestore firestore;
  SubcatgorRepImpl(this.firestore);

  @override
  Future<void> subcategory(
      {required String name, required String categoryId}) async {
    try {
      final subCategoryValues = await firestore
          .collection('category')
          .doc(categoryId)
          .collection('subcategory')
          .add({
        'id': null,
        'name': name,
        'timestamp': DateTime.now().toIso8601String(),
      });
      await subCategoryValues.update({'id': subCategoryValues.id});
    } catch (e) {
      throw Exception('Failed to upload the data $e');
    }
  }
}
