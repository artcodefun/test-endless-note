import 'package:endless_note/models/DayNotes.dart';

/// Manages [DayNotes] related work
abstract class DayNotesHandler {


  /// Tries to get a [DayNotes] of [day]
  Future<DayNotes> getDN(DateTime day);

  /// Tries to delete a [DayNotes] of [day]
  Future deleteDN(DateTime day);

  /// Tries to update a [DayNotes] of [day]
  Future<DayNotes> editDN(DateTime day);

  /// Should finish before any other usage
  Future init();

}