// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) => AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.nida,
    this.firstName,
    this.middleName,
    this.surname,
    this.email,
    this.phone,
    this.id,
  });

  String nida;
  String firstName;
  String middleName;
  String surname;
  String email;
  String phone;
  int id;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    nida: json["nida"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    surname: json["surname"],
    email: json["email"],
    phone: json["phone"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "nida": nida,
    "first_name": firstName,
    "middle_name": middleName,
    "surname": surname,
    "email": email,
    "phone": phone,
    "id": id,
  };
}
