import 'package:growmind_admin/features/tutors/domain/entities/tutor.dart';

abstract class TutorState {}

class TutorInitial extends TutorState {}

class TutorLoading extends TutorState {}

class TutorLoaded extends TutorState {
  final List<Tutor> tutors;
  TutorLoaded(this.tutors);
}

class TutorError extends TutorState {
  final String error;
  TutorError(this.error);
}
