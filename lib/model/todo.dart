import 'package:flutter_login_sqflite/repository/database_creator.dart';

class TodoModel {
  int id;
  int userId;
  String title;
  String description;

  TodoModel(this.id, this.userId, this.title, this.description);

  TodoModel.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.todoId];
    this.userId = json[DatabaseCreator.userId];
    this.title = json[DatabaseCreator.todoTitle];
    this.description = json[DatabaseCreator.todoDescription];
  }
}
