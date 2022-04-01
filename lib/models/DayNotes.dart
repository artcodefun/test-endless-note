import 'package:endless_note/models/Note.dart';

class DayNotes{
  final DateTime date;
  final Map<int,Note> notes;

  const DayNotes({
    required this.date,
    required this.notes,
  });

  DayNotes copyWith({
    DateTime? date,
    Map<int,Note>? notes,
  }) {
    return DayNotes(
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}