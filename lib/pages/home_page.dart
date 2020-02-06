import 'package:flutter/material.dart';
import 'package:flutter_login_sqflite/model/todo.dart';
import 'package:flutter_login_sqflite/pages/add_todo.dart';
import 'package:flutter_login_sqflite/repository/todoRepositoryService.dart';
import 'package:flutter_login_sqflite/utils/Constant.dart';
import 'package:flutter_login_sqflite/utils/PreferenceManager.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todoList = new List();
  var userId = "", userName = "", userEmail = "";

  @override
  initState() {
    super.initState();
    getUserUserId();
  }

  void getUserUserId() async {
    userId = await PreferenceManager().getPref(Constant.userID);
    userEmail = await PreferenceManager().getPref(Constant.userEmail);
    userName = await PreferenceManager().getPref(Constant.userName);
    getTodoList();
  }

  getTodoList() async {
    todoList = await TodoRepositoryService.getUserTodoList(userId);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          InkWell(
            onTap: () {
              PreferenceManager().remove();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((_) => MyHomePage())),
                  (Route<dynamic> route) => false);
            },
            child: Icon(Icons.lock),
          )
        ],
      ),
      body: Container(
        child: todoList.isNotEmpty
            ? Container(
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    TodoModel model = todoList[index];
                    return Container(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(model.title),
                            Text(model.description),
                          ],
                        ),
                      ),
                    );
                  }),
                  itemCount: todoList.length,
                ),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var result = await Navigator.push(
            context, MaterialPageRoute(builder: ((_) => AddTodo())));
        if(result != null){
          getTodoList();
        }
      }),
    );
  }
}
