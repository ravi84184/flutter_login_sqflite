import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_sqflite/pages/login_page.dart';

import 'pages/signUp_page.dart';
import 'repository/database_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginPage())));
                },
                child: Text("Login"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => SignUpPage())));
                },
                child: Text("Signup"),
              ),
            ],
          ),
        ));
  }
}
