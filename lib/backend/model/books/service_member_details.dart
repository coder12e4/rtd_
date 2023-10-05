// To parse this JSON data, do
//
//     final servicesMemberDetails = servicesMemberDetailsFromJson(jsonString);

import 'dart:convert';

ServicesMemberDetails servicesMemberDetailsFromJson(String str) =>
    ServicesMemberDetails.fromJson(json.decode(str));

String servicesMemberDetailsToJson(ServicesMemberDetails data) =>
    json.encode(data.toJson());

class ServicesMemberDetails {
  MemberDetails data;

  ServicesMemberDetails({
    required this.data,
  });

  factory ServicesMemberDetails.fromJson(Map<String, dynamic> json) =>
      ServicesMemberDetails(
        data: MemberDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class MemberDetails {
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

  MemberDetails({
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

  factory MemberDetails.fromJson(Map<String, dynamic> json) => MemberDetails(
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
