import 'package:flutter_login_sqflite/model/todo.dart';

import 'database_creator.dart';

class TodoRepositoryService {
  static Future<List<TodoModel>> getUserTodoList(userId) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}
      WHERE ${DatabaseCreator.userId} = ${userId}''';
    final data = await db.rawQuery(sql);

    List<TodoModel> todoList = new List();

    for (final node in data) {
      final todo = TodoModel.fromJson(node);
      todoList.add(todo);
    }
    return todoList;
  }

  static Future<void> addTodo(TodoModel todo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.todoTable}
    (
      ${DatabaseCreator.todoId},
      ${DatabaseCreator.userId},
      ${DatabaseCreator.todoTitle},
      ${DatabaseCreator.todoDescription}
    )
    VALUES (?,?,?,?)''';
    List<dynamic> params = [todo.id, todo.userId, todo.title, todo.description];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add Todo', sql, null, result, params);
  }

  static Future<int> userCount() async {
    final data = await db
        .rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.todoTable}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}
