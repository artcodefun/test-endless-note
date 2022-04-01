import 'package:endless_note/models/Note.dart';

class DayNotes{
  final DateTime date;
  final List<Note> notes;

  const DayNotes({
    required this.date,
    required this.notes,
  });

  DayNotes copyWith({
    DateTime? date,
    List<Note>? notes,
  }) {
    return DayNotes(
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}