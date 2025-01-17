import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/category/data/model/fetch_category_model.dart';

class CategoryRemoteDatasource {
  final FirebaseFirestore firestore;
  CategoryRemoteDatasource(this.firestore);

  Future<List<FetchCategoryModel>> fetchCategory() async {
    try {
    
      final snapshot = await firestore.collection('category').get();
      if (snapshot.docs.isEmpty) {
        throw Exception('No data found');
      }
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return FetchCategoryModel.fromFirestore({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw Exception('No value found');
    }
  }
}
