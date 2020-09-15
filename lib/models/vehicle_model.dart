// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  VehicleModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.nationalId,
    this.tagNumber,
    this.plateNumber,
    this.id,
  });

  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String nationalId;
  String tagNumber;
  String plateNumber;
  int id;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    nationalId: json["national_id"],
    tagNumber: json["tag_number"],
    plateNumber: json["plate_number"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "national_id": nationalId,
    "tag_number": tagNumber,
    "plate_number": plateNumber,
    "id": id,
  };
}
