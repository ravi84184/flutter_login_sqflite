import 'package:flutter/material.dart';
import 'package:flutter_login_sqflite/model/user.dart';
import 'package:flutter_login_sqflite/pages/home_page.dart';
import 'package:flutter_login_sqflite/repository/userRepositoryService.dart';
import 'package:flutter_login_sqflite/utils/Constant.dart';
import 'package:flutter_login_sqflite/utils/PreferenceManager.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
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
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                user =
                    await UserRepositoryService.checkUserLogin(email, password);
                if (user != null) {
                  PreferenceManager()
                      .setPref(Constant.userID, user.id.toString());
                  PreferenceManager()
                      .setPref(Constant.userEmail, user.email.toString());
                  PreferenceManager()
                      .setPref(Constant.userName, user.name.toString());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: ((_) => HomePage())),
                      (Route<dynamic> route) => false);
                }
              }
            },
            child: Text("Login"),
          ),
          user != null ? Text(user.name.toString()) : Container()
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
