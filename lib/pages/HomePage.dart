import 'package:endless_note/components/DayCard.dart';
import 'package:endless_note/models/DayNotes.dart';
import 'package:flutter/material.dart';

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
          itemBuilder: (ctx, i) => DayCard(
              dayNotes: DayNotes(
                  notes: {},
                  date: today.subtract(Duration(days: i * 1))))),
    );
  }
}
