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
    bool makeNewMap =false
  }) {
    Map<int,Note> newNotes = notes ?? this.notes;

    if(makeNewMap){
      var m = newNotes;
      newNotes = {};
      m.forEach((key, value) {
        newNotes[key]=value;
      });
    }

    return DayNotes(
      date: date ?? this.date,
      notes: newNotes,
    );
  }
}