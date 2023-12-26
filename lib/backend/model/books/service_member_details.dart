// To parse this JSON data, do
//
//     final servicesMemberDetails = servicesMemberDetailsFromJson(jsonString);

import 'dart:convert';

ServicesMemberDetails servicesMemberDetailsFromJson(String str) =>
    ServicesMemberDetails.fromJson(json.decode(str));

String servicesMemberDetailsToJson(ServicesMemberDetails data) =>
    json.encode(data.toJson());

class ServicesMemberDetails {
  bool status;
  MemberDetails data;
  String message;
  String accessToken;
  String tokenType;

  ServicesMemberDetails({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory ServicesMemberDetails.fromJson(Map<String, dynamic> json) =>
      ServicesMemberDetails(
        status: json["status"],
        data: MemberDetails.fromJson(json["data"]),
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class MemberDetails {
  int id;
  String name;
  String email;
  String profileImage;
  int stateId;
  int serviceId;
  String location;
  String ksaMobileNumber;
  String highlights;
  DateTime createdAt;
  DateTime updatedAt;
  String service;

  MemberDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.stateId,
    required this.serviceId,
    required this.location,
    required this.ksaMobileNumber,
    required this.highlights,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) => MemberDetails(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profile_image"],
        stateId: json["state_id"],
        serviceId: json["service_id"],
        location: json["location"],
        ksaMobileNumber: json["ksa_mobile_number"],
        highlights: json["highlights"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_image": profileImage,
        "state_id": stateId,
        "service_id": serviceId,
        "location": location,
        "ksa_mobile_number": ksaMobileNumber,
        "highlights": highlights,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service": service,
      };
}
