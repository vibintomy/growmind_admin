import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/home/data/datasource/admin_datasource.dart';
import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';

class AdminDatasourceImpl implements AdminDatasource {
  final FirebaseFirestore firebaseFirestore;
  AdminDatasourceImpl(this.firebaseFirestore);

  @override
  Future<AdminEntities> getAdminStats() async {
    try {
      final DocumentReference adminRef =
          firebaseFirestore.collection('admin').doc('stats');
      final DocumentSnapshot documentSnapshot = await adminRef.get();
      if (!documentSnapshot.exists) {
        throw Exception('No user found for the current data');
      }
      final Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      final int totalRevenue = data['totalRevenue'] ?? 0;
      final Map<String, dynamic> courseData = data['courses'] ?? {};
      Map<String, CourseState> courses = {};
      courseData.forEach((key, value) {
        courses[key] = CourseState(
            name: value['name'] ?? '',
            purchase: value['purchase'] ?? 0,
            revenue: value['revenue'] ?? 0);
      });
      return AdminEntities(totalRevenue: totalRevenue, course: courses);
    } catch (e) {
      throw Exception('Failed to get the values from the admin');
    }
  }
}
