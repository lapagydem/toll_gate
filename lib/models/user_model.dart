// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.name,
    this.job,
    this.id,
  });

  String name;
  String job;
  int id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    job: json["job"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "job": job,
    "id": id,
  };
}
