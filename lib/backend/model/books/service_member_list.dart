// To parse this JSON data, do
//
//     final servicesMemberList = servicesMemberListFromJson(jsonString);

import 'dart:convert';

ServicesMemberList servicesMemberListFromJson(String str) =>
    ServicesMemberList.fromJson(json.decode(str));

String servicesMemberListToJson(ServicesMemberList data) =>
    json.encode(data.toJson());

class ServicesMemberList {
  bool status;
  List<MemberList> data;
  String message;
  String accessToken;
  String tokenType;

  ServicesMemberList({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory ServicesMemberList.fromJson(Map<String, dynamic> json) =>
      ServicesMemberList(
        status: json["status"],
        data: List<MemberList>.from(
            json["data"].map((x) => MemberList.fromJson(x))),
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class MemberList {
  int id;
  String name;
  String email;
  String profileImage;
  int stateId;
  int serviceId;
  String indiaMobileNumber;
  String ksaMobileNumber;
  int bloodGroup;
  DateTime createdAt;
  DateTime updatedAt;
  String service;
  String bloodGroupName;

  MemberList({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.stateId,
    required this.serviceId,
    required this.indiaMobileNumber,
    required this.ksaMobileNumber,
    required this.bloodGroup,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
    required this.bloodGroupName,
  });

  factory MemberList.fromJson(Map<String, dynamic> json) => MemberList(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profile_image"],
        stateId: json["state_id"],
        serviceId: json["service_id"],
        indiaMobileNumber: json["india_mobile_number"],
        ksaMobileNumber: json["ksa_mobile_number"],
        bloodGroup: json["blood_group"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        service: json["service"],
        bloodGroupName: json["blood_group_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_image": profileImage,
        "state_id": stateId,
        "service_id": serviceId,
        "india_mobile_number": indiaMobileNumber,
        "ksa_mobile_number": ksaMobileNumber,
        "blood_group": bloodGroup,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "service": service,
        "blood_group_name": bloodGroupName,
      };
}
