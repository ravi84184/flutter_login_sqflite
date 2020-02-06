import '../model/user.dart';
import 'database_creator.dart';

class UserRepositoryService {
  static Future<List<User>> getAllUser() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.userTable}
      ''';
//      WHERE ${DatabaseCreator.id} == 0''';
    final data = await db.rawQuery(sql);

    List<User> userList = new List();

    for (final node in data) {
      final todo = User.fromJson(node);
      userList.add(todo);
    }
    return userList;
  }

  static Future<User> getUserDetails(int id) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.userTable}
      WHERE ${DatabaseCreator.id} == $id''';
    final data = await db.rawQuery(sql);
    if (data.isNotEmpty) {
      final todo = User.fromJson(data[0]);
      return todo;
    } else {}
  }

  static Future<User> checkUserLogin(String email, String password) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.userTable}
      WHERE ${DatabaseCreator.email} == "$email" AND ${DatabaseCreator.password} == "$password"''';
    final data = await db.rawQuery(sql);
    if (data.isNotEmpty) {
      final todo = User.fromJson(data[0]);
      return todo;
    } else {
      return null;
    }
  }
  static Future<bool> deleteUser(int id) async {
    final sql = '''DELETE FROM ${DatabaseCreator.userTable}
      WHERE ${DatabaseCreator.id} = "$id"''';
    final data = await db.rawQuery(sql);
    return true;
  }

  static Future<void> addUsers(User todo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.userTable}
    (
      ${DatabaseCreator.id},
      ${DatabaseCreator.name},
      ${DatabaseCreator.email},
      ${DatabaseCreator.password}
    )
    VALUES (?,?,?,?)''';
    List<dynamic> params = [todo.id, todo.name, todo.email, todo.password];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add User', sql, null, result, params);
  }

  static Future<int> userCount() async {
    final data = await db
        .rawQuery('''SELECT COUNT(*) FROM ${DatabaseCreator.userTable}''');

    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    return idForNewItem;
  }
}
