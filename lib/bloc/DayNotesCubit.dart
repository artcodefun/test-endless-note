import 'package:endless_note/bloc/DayNotesState.dart';
import 'package:endless_note/models/DayNotes.dart';
import 'package:endless_note/models/Note.dart';
import 'package:endless_note/services/DayNotesHandler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayNotesCubit extends Cubit<DayNotesState> {
  DayNotesCubit({required this.day, required DayNotesHandler dnh})
      : _dnh = dnh,
        super(DayNotesState()){_loadDay(day);}

  final DayNotesHandler _dnh;
  final DateTime day;

  _loadDay(DateTime day) async {
    emit(state.copyWith(status: DayNotesStateStatus.loading));
    DayNotes dn = await _dnh.getDN(day);
    emit(state.copyWith(status: DayNotesStateStatus.active, dayNotes: dn));
  }

  refreshDay()async{
    emit(state.copyWith(status: DayNotesStateStatus.loading));
    await _dnh.refreshDN(day);
    DayNotes dn = await _dnh.getDN(day);
    emit(state.copyWith(status: DayNotesStateStatus.active, dayNotes: dn));
  }

  sendDayUpdates()async{
    if(state.dayNotes==null) return;
    await _dnh.updateDN(state.dayNotes!);
  }

  deleteNote(int noteId) async {
    var newDN = state.dayNotes!.copyWith(makeNewMap: true)..notes.remove(noteId);
    // await _dnh.updateDN(newDN);
    emit(state.copyWith(dayNotes: newDN));
  }

  Future<DayNotes> addNote(Note note) async {
    var newDN = state.dayNotes!.copyWith(makeNewMap: true);
    int newKey=1;
    for(int k in newDN.notes.keys){
      if(k>=newKey) {
        newKey=k+1;
      }
    }
    newDN.notes[newKey]=note;
    // await _dnh.updateDN(newDN);
    emit(state.copyWith(dayNotes: newDN));
    return newDN;
  }

  editNote(int key, Note note) async{
    var newDN = state.dayNotes!.copyWith(makeNewMap: true)..notes[key]=note;
    // await _dnh.updateDN(newDN);
    emit(state.copyWith(dayNotes: newDN));

  }
}
