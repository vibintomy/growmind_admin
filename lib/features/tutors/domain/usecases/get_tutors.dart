import 'package:growmind_admin/features/tutors/domain/entities/tutor.dart';
import 'package:growmind_admin/features/tutors/domain/repo/tutor_repo.dart';

class GetTutors {
  final TutorRepository repository;

  GetTutors(this.repository);

  Future<List<Tutor>> call() async {
  
    final Tutor = await repository.fetchTutor();
  
    return Tutor;
  }
}
