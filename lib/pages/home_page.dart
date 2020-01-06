import 'package:flutter/material.dart';
import 'package:flutter_login_sqflite/model/user.dart';
import 'package:flutter_login_sqflite/repository/repository_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<User>> future;

  @override
  initState() {
    super.initState();
    future = RepositoryService.getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder<List<User>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children:
                        snapshot.data.map((todo) => buildItem(todo)).toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildItem(User todo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'name: ${todo.name}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'email: ${todo.email}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                /*FlatButton(
                  onPressed: () => updateTodo(todo),
                  child: Text('Update todo',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),*/
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () {
//                    deleteTodo(todo);
                  },
                  child: Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
