import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_admin/features/tutors/domain/usecases/get_tutors.dart';

import 'package:growmind_admin/features/tutors/presentation/bloc/tutor_event.dart';
import 'package:growmind_admin/features/tutors/presentation/bloc/tutor_state.dart';

class TutorBloc extends Bloc<TutorEvent, TutorState> {
  final GetTutors getTutors;
  TutorBloc(this.getTutors) : super(TutorInitial()) {
    on<FetchTutorEvent>((event, emit) async {
      emit(TutorLoading());

      try {
        final tutors = await getTutors.call();
        final filteredTutor =
            tutors.where((tutor) => tutor.status != 'rejected').toList();
        emit(TutorLoaded(filteredTutor));
      } catch (e) {
        emit(TutorError(e.toString()));
      }
    });
    on<RemoveTutorEvent>((event, emit) async {
      if (state is TutorLoaded) {
        final currentState = state as TutorLoaded;
        final currentTutors = currentState.tutors;
        final upadatedTutors =
            currentTutors.where((tutor) => tutor.id != event.id).toList();
        emit(TutorLoaded(upadatedTutors));
      }
    });
  }
}
