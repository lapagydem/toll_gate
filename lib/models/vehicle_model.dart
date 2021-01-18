// To parse this JSON data, do
//
//     final vehicle = vehicleFromJson(jsonString);

import 'dart:convert';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  Vehicle({
    this.status,
    this.tagNo,
    this.accountNo,
    this.plateNo,
    this.message,
  });

  int status;
  String tagNo;
  String accountNo;
  String plateNo;
  String message;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    status: json["status"],
    tagNo: json["tag_no"],
    accountNo: json["account_no"],
    plateNo: json["plate_no"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "tag_no": tagNo,
    "account_no": accountNo,
    "plate_no": plateNo,
    "message": message,
  };
}
