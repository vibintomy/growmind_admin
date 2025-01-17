import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/tutors/data/model/tutor_model.dart';

class TutorRemoteDatasource {
  final FirebaseFirestore firestore;
  TutorRemoteDatasource(this.firestore);

  Future<List<TutorModel>> fetchTutor() async {
    try {
      final snapshot = await firestore.collection('kyc').get();
      if (snapshot.docs.isEmpty) {
        throw Exception('No values found');
      }     
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return TutorModel.fromFirestore({
          ...data,
          'id': doc.id, 
        });
      }).toList();
    } catch (e) {

      throw Exception('No data found');
    }
  }
}

