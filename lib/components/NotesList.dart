import 'package:endless_note/models/Note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/DayNotesCubit.dart';
import '../models/DayNotes.dart';
import 'NoteItem.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  bool canChangeList = true;

  static const actionDuration = Duration(milliseconds: 250);

  listLock(Future Function() f) async {
    if (!canChangeList) return;
    canChangeList = false;
    try {
      await f();
    } finally {
      canChangeList = true;
    }
  }

  getKeyByIndex(DayNotes dn, int index) =>
      (dn.notes.keys.toList()..sort())[index];

  @override
  Widget build(BuildContext context) {
    DayNotesCubit dnc = context.watch();
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: _listKey,
            initialItemCount: dnc.state.dayNotes!.notes.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                    .animate(animation),
                child: NoteItem(
                    key: ValueKey(getKeyByIndex(dnc.state.dayNotes!, index)),
                    note: dnc.state.dayNotes!
                            .notes[getKeyByIndex(dnc.state.dayNotes!, index)] ??
                        const Note(text: ""),
                    onDelete: () => listLock(() async {
                          _listKey.currentState?.removeItem(
                              index,
                              (context, animation) => SlideTransition(
                                    position: Tween<Offset>(
                                            begin: Offset(1, 0),
                                            end: Offset(0, 0))
                                        .animate(animation),
                                    child: NoteItem(
                                        key: ValueKey(getKeyByIndex(
                                            dnc.state.dayNotes!, index)),
                                        note: dnc.state.dayNotes!.notes[
                                                getKeyByIndex(
                                                    dnc.state.dayNotes!,
                                                    index)] ??
                                            const Note(text: ""),
                                        onDelete: () {},
                                        onEdited: (s) {}),
                                  ),
                              duration: actionDuration);

                          await dnc.deleteNote(
                              getKeyByIndex(dnc.state.dayNotes!, index));
                        }),
                    onEdited: (s) async {
                      await dnc.editNote(
                          getKeyByIndex(dnc.state.dayNotes!, index),
                          Note(text: s));
                    }),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () => listLock(() async {
              var dn = await dnc.addNote(Note(text: "new Note!!!"));
              _listKey.currentState
                  ?.insertItem(dn.notes.length - 1, duration: actionDuration);
              // await Future.delayed(actionDuration);
            }),
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
