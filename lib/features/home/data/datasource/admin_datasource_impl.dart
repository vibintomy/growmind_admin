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
      final Map<String, dynamic> courseData = 
          (data['courses'] is Map<String, dynamic>) ? data['courses'] : {};

      // Ensure courses have valid structure
      List<MapEntry<String, dynamic>> sortedCourses = courseData.entries
          .where((entry) => entry.value is Map<String, dynamic>) // Avoid invalid data
          .toList()
          ..sort((a, b) => (b.value['purchases'] ?? 0).compareTo(a.value['purchases'] ?? 0));

      // Get the top 5 courses based on purchases
      Map<String, CourseState> courses = {};
      for (var entry in sortedCourses.take(5)) {
        final value = entry.value as Map<String, dynamic>;
        courses[entry.key] = CourseState(
          name: value['name'] ?? 'Unknown',
          purchase: value['purchases'] ?? 0,
          revenue: value['revenue'] ?? 0,
        );
      }

      return AdminEntities(totalRevenue: totalRevenue, course: courses);
    } catch (e, stackTrace) {
      print('Error fetching admin stats: $e\nStack Trace: $stackTrace');
      throw Exception('Failed to retrieve admin statistics: $e');
    }
  }
}
