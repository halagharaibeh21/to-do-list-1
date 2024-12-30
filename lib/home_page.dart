import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box _todoBox = Hive.box('todoBox');

  void _addTask(String task) {
    final newTask = ToDo(task: task);
    setState(() {
      _todoBox.add(newTask); // Save as ToDo object
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _todoBox.deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _todoBox.listenable(),
        builder: (context, box, _) {
          return ListView.builder(
            itemCount: _todoBox.length,
            itemBuilder: (context, index) {
              final todo = _todoBox.getAt(index) as ToDo;
              return ListTile(
                title: Text(todo.task),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTask(index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTask = '';
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  onChanged: (value) {
                    newTask = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newTask.isNotEmpty) {
                        _addTask(newTask);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
