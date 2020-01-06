import 'package:flutter/material.dart';
import 'package:flutter_login_sqflite/model/user.dart';
import 'package:flutter_login_sqflite/repository/repository_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;

  void createUser(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      int count = await RepositoryService.userCount();
      final todo = User(count, name, email, password);
      await RepositoryService.addUsers(todo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: loginFormWidgets(),
              key: _formKey,
            ),
          ),
          RaisedButton(
            onPressed: () {
              createUser(context);
            },
            child: Text("Login"),
          )
        ],
      ),
    );
  }

  Widget loginFormWidgets() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Name',
            fillColor: Colors.grey[200],
            filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter name';
            }
          },
          onSaved: (value) => name = value,
        ),
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Email',
            fillColor: Colors.grey[200],
            filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter email';
            }
          },
          onSaved: (value) => email = value,
        ),
        SizedBox(
          height: 2,
        ),
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
            fillColor: Colors.grey[200],
            filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter password';
            }
          },
          onSaved: (value) => password = value,
        )
      ],
    );
  }
}
