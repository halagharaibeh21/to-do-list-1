import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'todo.dart';

class ToDoList extends StatelessWidget {
  final Box _todoBox = Hive.box('todoBox');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _todoBox.length,
      itemBuilder: (context, index) {
        final todo = _todoBox.getAt(index) as ToDo;
        return ListTile(
          title: Text(todo.task),
        );
      },
    );
  }
}
