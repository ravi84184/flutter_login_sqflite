import 'package:flutter_login_sqflite/repository/database_creator.dart';

class User{
  int id;
  String name;
  String email;
  String password;

  User(this.id, this.name, this.email, this.password);

  User.fromJson(Map<String,dynamic> json){
    this.id = json[DatabaseCreator.id];
    this.name = json[DatabaseCreator.name];
    this.email = json[DatabaseCreator.email];
    this.password = json[DatabaseCreator.password];
  }

}