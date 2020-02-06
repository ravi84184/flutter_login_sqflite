import 'package:flutter/material.dart';
import 'package:flutter_login_sqflite/model/todo.dart';
import 'package:flutter_login_sqflite/repository/todoRepositoryService.dart';
import 'package:flutter_login_sqflite/utils/Constant.dart';
import 'package:flutter_login_sqflite/utils/PreferenceManager.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  var userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _textField("Title", _titleController),
            _textField("Description", _descriptionController),
            RaisedButton(
              onPressed: () {
                _addTodo(context);
              },
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }

  Widget _textField(hint, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: hint),
    );
  }

  Future<void> _addTodo(BuildContext context) async {
    if (_titleController.text.toString() == "") {
      return;
    }
    if (_descriptionController.text.toString() == "") {
      return;
    }
    int count = await TodoRepositoryService.userCount();
    final todo = TodoModel(count, int.parse(userId), _titleController.text.toString(),
        _descriptionController.text.toString());
    await TodoRepositoryService.addTodo(todo);
    Navigator.pop(context, true);
  }

  Future<void> getUserId() async {
    userId = await PreferenceManager().getPref(Constant.userID);
  }
}
