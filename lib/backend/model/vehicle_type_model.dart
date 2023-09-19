// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  bool status;
  List<VehicleData> data;
  String message;

  VehicleModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    status: json["status"],
    data: List<VehicleData>.from(json["data"].map((x) => VehicleData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class VehicleData {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  VehicleData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) => VehicleData(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
