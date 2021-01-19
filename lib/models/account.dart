// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  Account({
    this.id,
    this.nida,
    this.firstName,
    this.middleName,
    this.surname,
    this.username,
    this.phone,
    this.email,
    this.passwordHash,
    this.passwordResetToken,
    this.status,
    this.lastLogin,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  int id;
  String nida;
  String firstName;
  String middleName;
  String surname;
  String username;
  String phone;
  String email;
  String passwordHash;
  String passwordResetToken;
  int status;
  DateTime lastLogin;
  dynamic createdBy;
  DateTime createdAt;
  int updatedBy;
  DateTime updatedAt;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    nida: json["nida"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    surname: json["surname"],
    username: json["username"],
    phone: json["phone"],
    email: json["email"],
    passwordHash: json["password_hash"],
    passwordResetToken: json["password_reset_token"],
    status: json["status"],
    lastLogin: DateTime.parse(json["last_login"]),
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nida": nida,
    "first_name": firstName,
    "middle_name": middleName,
    "surname": surname,
    "username": username,
    "phone": phone,
    "email": email,
    "password_hash": passwordHash,
    "password_reset_token": passwordResetToken,
    "status": status,
    "last_login": lastLogin.toIso8601String(),
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt.toIso8601String(),
  };
}
