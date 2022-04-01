import 'package:endless_note/models/DayNotes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DayCard extends StatelessWidget {
  const DayCard({Key? key, required this.dayNotes}) : super(key: key);

  final DayNotes dayNotes;

  String dateDisplay(DateTime d) => "${d.year}/${d.month}/${d.day}";

  Color randColor(Random r) {
    Color c;
    do {
      c = Color.fromARGB(255, r.nextInt(256), r.nextInt(256), r.nextInt(256));
    } while (c.computeLuminance() < 0.5);

    return c;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var r = Random(dayNotes.date.millisecondsSinceEpoch);
    return Container(
      decoration: BoxDecoration(
          image: dayNotes.notes.isEmpty
              ? null
              : DecorationImage(
                  image: AssetImage("assets/patterns/${r.nextInt(18) + 1}.png"),
                  repeat: ImageRepeat.repeat),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 5),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(25),
          color: dayNotes.notes.isEmpty ? theme.colorScheme.surface : randColor(r)),
      margin: const EdgeInsets.all(10),
      height: 200,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          dateDisplay(dayNotes.date),
          style: theme.textTheme.headline4?.copyWith(
              color: theme.colorScheme.onSurface, fontWeight: FontWeight.w600),
        )
      ]),
    );
  }
}
