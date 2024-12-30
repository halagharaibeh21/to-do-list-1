import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'todo.dart';
import 'home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter()); // Register ToDo adapter
  await Hive.openBox('todoBox'); // Open Hive box
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
