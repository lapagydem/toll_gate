// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  VehicleModel({
    this.status,
    this.vehicle,
    this.details,
  });

  int status;
  Vehicle vehicle;
  Details details;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    status: json["status"],
    vehicle: Vehicle.fromJson(json["vehicle"]),
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "vehicle": vehicle.toJson(),
    "details": details.toJson(),
  };
}

class Details {
  Details({
    this.accountId,
    this.vehicleId,
    this.id,
  });

  String accountId;
  int vehicleId;
  int id;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    accountId: json["account_id"],
    vehicleId: json["vehicle_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "vehicle_id": vehicleId,
    "id": id,
  };
}

class Vehicle {
  Vehicle({
    this.plateNo,
    this.rfidTagNo,
    this.bodyTypeId,
    this.id,
  });

  String plateNo;
  String rfidTagNo;
  String bodyTypeId;
  int id;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    plateNo: json["plate_no"],
    rfidTagNo: json["rfid_tag_no"],
    bodyTypeId: json["body_type_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "plate_no": plateNo,
    "rfid_tag_no": rfidTagNo,
    "body_type_id": bodyTypeId,
    "id": id,
  };
}
