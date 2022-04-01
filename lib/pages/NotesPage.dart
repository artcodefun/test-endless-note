import 'package:endless_note/bloc/DayNotesCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    DayNotesCubit dnc = context.watch();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Image(
                repeat: ImageRepeat.repeat,
                alignment: Alignment.center,
                image: AssetImage('assets/images/hh.jpg'),
                width: 200,
                height: 200,
              ),
            ),
            Positioned.fill(
                child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_back,
                      color: theme.colorScheme.surface,
                      size: 30,
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
