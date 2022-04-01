import 'package:endless_note/bloc/DayNotesState.dart';
import 'package:endless_note/models/DayNotes.dart';
import 'package:endless_note/services/DayNotesHandler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayNotesCubit extends Cubit<DayNotesState> {
  DayNotesCubit({required DateTime day, required DayNotesHandler dnh})
      : _dnh = dnh,
        super(DayNotesState()){_loadDay(day);}

  final DayNotesHandler _dnh;

  _loadDay(DateTime day) async {
    emit(state.copyWith(status: DayNotesStateStatus.loading));
    DayNotes dn = await _dnh.getDN(day);
    emit(state.copyWith(status: DayNotesStateStatus.active, dayNotes: dn));
  }

  deleteNote() {}

  addNote() {}

  editNote(int key) {}
}
