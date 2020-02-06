import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_sqflite/pages/home_page.dart';
import 'package:flutter_login_sqflite/pages/login_page.dart';
import 'package:flutter_login_sqflite/utils/PreferenceManager.dart';

import 'pages/signUp_page.dart';
import 'repository/database_creator.dart';
import 'utils/Constant.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkUserIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
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

  void checkUserIsLogin() async {
    var userId = await PreferenceManager().getPref(Constant.userID);
    if (userId != "") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((_) => HomePage())),
          (Route<dynamic> route) => false);
    }
  }
}
