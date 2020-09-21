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
  String email;
  String password;
  double Latitude;
  double Longitude;
  String Address;

  UserModel({
    this.email,
    this.password,
    this.Latitude,
    this.Longitude,
    this.Address
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    password: json["password"],
    Latitude: json["Latitude"],
    Longitude: json["Longitude"],
    Address:  json["Address"],
    //createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "Latitude": Latitude,
    "Longitude" : Longitude,
    "Address" : Address
    //"createdAt": createdAt.toIso8601String(),
  };
}

/*
class Iuser {
  String StoreName;
  String Password;

  Iuser({this.StoreName,this.Password});
}
*/




