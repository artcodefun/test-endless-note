import 'package:endless_note/models/DayNotes.dart';

import '../models/Note.dart';

/// Manages [DayNotes] related work
abstract class DayNotesHandler {


  /// Tries to get a [DayNotes] of [day]
  Future<DayNotes> getDN(DateTime day);

  /// Tries to refresh a [DayNotes] of [day]
  Future refreshDN(DateTime day);

  /// Tries to update [dayNotes]
  Future updateDN(DayNotes dayNotes);

  /// Should finish before any other usage
  Future init();

}