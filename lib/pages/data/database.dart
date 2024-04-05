import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List todoList = [];
  //reference box
  final _myBox = Hive.box('myBox');
  //* run this method for first time open app ever
  void createInitialData() {
    todoList = [];
  }

  //* load data from db
  void loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  //* update db
  void updateDataBase() {
    _myBox.put("TODO:IST", todoList);
  }
}
