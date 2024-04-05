// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_list/pages/data/database.dart';
import 'package:flutter_list/utilities/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();

  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    //* if this first time ever open app , then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //* there already exists data
      db.loadData();
    }

    super.initState();
  }

//* checkbox changed
  void completeTask(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
  }

  //* saveTask function
  void saveTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //* deleteTask function
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  //* create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
          title: Text(
            'TO DO',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow,
        shape: CircleBorder(),
        child: Icon(Icons.create),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => completeTask(value, index),
            deleteTodo: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
