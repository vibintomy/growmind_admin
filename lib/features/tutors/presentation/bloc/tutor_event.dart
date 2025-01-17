abstract class TutorEvent {}

class FetchTutorEvent extends TutorEvent {}

class RemoveTutorEvent extends TutorEvent {
  final String id;
  RemoveTutorEvent(this.id);
}


