import 'package:endless_note/bloc/DayNotesCubit.dart';
import 'package:endless_note/components/DayCard.dart';
import 'package:endless_note/models/DayNotes.dart';
import 'package:endless_note/pages/NotesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/DayNotesState.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const SizedBox(
          width: double.maxFinite,
          child: Image(
            repeat: ImageRepeat.repeat,
            alignment: Alignment.center,
            image: AssetImage('assets/images/gz.jpg'),
            width: 200,
            height: 200,
          ),
        ),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, i) =>
              BlocProvider(
                create: (BuildContext c) =>
                    DayNotesCubit(
                        day: today.subtract(Duration(days: i * 1)),
                        dnh: context.read()),
                child: BlocBuilder<DayNotesCubit, DayNotesState>(
                  builder: (blocCtx, state) =>
                  state.status == DayNotesStateStatus.active
                      ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => BlocProvider<DayNotesCubit>.value(
                              child: const NotesPage(),
                                value: blocCtx.read())));
                      },
                      child: DayCard(dayNotes: state.dayNotes!))
                      : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: DayCard(
                        dayNotes: DayNotes(notes: {}, date: today)),
                  ),
                ),
              )),
    );
  }
}
