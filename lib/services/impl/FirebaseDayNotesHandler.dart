import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endless_note/models/DayNotes.dart';
import 'package:endless_note/models/Note.dart';
import 'package:endless_note/services/DayNotesHandler.dart';
import 'package:firebase_core/firebase_core.dart';

/// [DayNotesHandler] that uses Firebase
class FirebaseDayNotesHandler implements DayNotesHandler {
  static const notesPath = "notes";
  static const monthPath = "month";
  static const daysPath = "days";

  late CollectionReference notes;

  Map<String, List<DayNotes>> loadedMonths = {};

  String monthId(DateTime d) => "${d.year}-${d.month}";

  Future loadMonth(DateTime date) async {
    var m = await notes.doc("${date.year}/$monthPath/${date.month}").get();

    if (!m.exists) {
      loadedMonths[monthId(date)] = [];
      return;
    }

    List<DayNotes> month = [];
    var days = (m.get(daysPath) as Map).cast<String, Map>();

    for (var d in days.keys) {
      month.add(DayNotes(
          date: DateTime(date.year, date.month, int.parse(d)),
          notes: days[d]?.cast<String, String>().map((key, value) =>
              MapEntry(int.parse(key), Note(text: value))) ??
              {}));
    }

    loadedMonths[monthId(date)] = month;
  }

  bool sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Future deleteDN(DateTime day) {
    // TODO: implement deleteDN
    throw UnimplementedError();
  }

  @override
  Future<DayNotes> editDN(DateTime day) {
    // TODO: implement editDN
    throw UnimplementedError();
  }

  @override
  Future<DayNotes> getDN(DateTime day) async {
    if (!loadedMonths.containsKey(monthId(day))) {
      await loadMonth(day);
    }
    return loadedMonths[monthId(day)]!.firstWhere((d) =>sameDay(d.date, day), orElse: ()=>DayNotes(date: day, notes: {}));

  }

  @override
  Future init() async {
    await Firebase.initializeApp();
    notes = FirebaseFirestore.instance.collection(notesPath);
  }
}
