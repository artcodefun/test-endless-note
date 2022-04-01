import 'package:endless_note/models/DayNotes.dart';

enum DayNotesStateStatus {
  created, loading, active
}

class DayNotesState{
  DayNotesStateStatus status;
  DayNotes? dayNotes;

  DayNotesState({
    this.status = DayNotesStateStatus.created,
    this.dayNotes,
  });

  DayNotesState copyWith({
    DayNotesStateStatus? status,
    DayNotes? dayNotes,
  }) {
    return DayNotesState(
      status: status ?? this.status,
      dayNotes: dayNotes ?? this.dayNotes,
    );
  }
}