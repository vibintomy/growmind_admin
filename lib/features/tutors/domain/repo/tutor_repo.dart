import 'package:growmind_admin/features/tutors/domain/entities/tutor.dart';

abstract class TutorRepository {
  Future<List<Tutor>> fetchTutor();
  
}

