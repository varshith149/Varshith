/*class CounterViewModel {
  int counter = 0;

  CounterViewModel(this.counter);
}*/

// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String password;
  String id;
  DateTime createdAt;

  UserModel({
    this.name,
    this.password,
    this.id,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    password: json["password"],
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
    "id": id,
    "createdAt": createdAt.toIso8601String(),
  };
}

/*
class Iuser {
  String StoreName;
  String Password;

  Iuser({this.StoreName,this.Password});
}
*/




