import 'package:endless_note/pages/HomePage.dart';
import 'package:endless_note/services/DayNotesHandler.dart';
import 'package:endless_note/services/impl/FirebaseDayNotesHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DayNotesHandler dnh = FirebaseDayNotesHandler();
  await dnh.init();

  runApp(MultiProvider(
    providers: [Provider.value(value: dnh)],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Endless Note',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
