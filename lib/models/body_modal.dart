// To parse this JSON data, do
//
//     final bodyTypeModel = bodyTypeModelFromJson(jsonString);

import 'dart:convert';

BodyTypeModel bodyTypeModelFromJson(String str) => BodyTypeModel.fromJson(json.decode(str));

String bodyTypeModelToJson(BodyTypeModel data) => json.encode(data.toJson());

class BodyTypeModel {
  BodyTypeModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  int isActive;
  dynamic createdBy;
  dynamic createdAt;
  dynamic updatedBy;
  dynamic updatedAt;

  factory BodyTypeModel.fromJson(Map<String, dynamic> json) => BodyTypeModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "is_active": isActive,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_by": updatedBy,
    "updated_at": updatedAt,
  };
}
