import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_admin/features/tutors/data/datasource/tutor_remote_datasource.dart';
import 'package:growmind_admin/features/tutors/domain/entities/tutor.dart';
import 'package:growmind_admin/features/tutors/domain/repo/tutor_repo.dart';

class TutorRepositoryimpl implements TutorRepository {
  final TutorRemoteDatasource remoteDatasource;
  final FirebaseFirestore firestore;
  TutorRepositoryimpl(this.remoteDatasource, this.firestore);

  @override
  Future<List<Tutor>> fetchTutor() async {
    final tutorModel = await remoteDatasource.fetchTutor();
  
    if (tutorModel == null) {
      throw Exception('No data');
    }
    return tutorModel.map((model) {
      return Tutor(
          id: model.id,
          name: model.name.toString(),
          vemail: model.vemail.toString(),
          profession: model.profession.toString(),
          pdfUrl: model.pdfUrl.toString(),
          status: model.status.toString());
    }).toList();
  }
}


// @override
  // Future<void> deleteTutor(String id) async {
  //   await firestore.collection('kyc').doc(id).delete();
  // }