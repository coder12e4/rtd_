// To parse this JSON data, do
//
//     final surties = surtiesFromJson(jsonString);

import 'dart:convert';

Surties surtiesFromJson(String str) => Surties.fromJson(json.decode(str));

String surtiesToJson(Surties data) => json.encode(data.toJson());

class Surties {
  bool status;
  List<SuretiesData> data;
  String message;
  String accessToken;
  String tokenType;

  Surties({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory Surties.fromJson(Map<String, dynamic> json) => Surties(
        status: json["status"],
        data: List<SuretiesData>.from(
            json["data"].map((x) => SuretiesData.fromJson(x))),
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

class SuretiesData {
  int id;
  String memberId;
  String name;
  String email;
  String profileImage;
  dynamic emailVerifiedAt;
  int verificationStatus;
  String indiaMobileNumber;
  String ksaMobileNumber;
  int bloodGroup;
  String indianAddress1;
  String indianAddress2;
  String indiaState;
  String indiaPin;
  String? documentProofIndia;
  String ksaAddress1;
  String ksaAddress2;
  int ksaState;
  String ksaPin;
  String? documentProofKsa;
  int vehicleTypeId;
  String vehicleNumber;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  SuretiesData({
    required this.id,
    required this.memberId,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.emailVerifiedAt,
    required this.verificationStatus,
    required this.indiaMobileNumber,
    required this.ksaMobileNumber,
    required this.bloodGroup,
    required this.indianAddress1,
    required this.indianAddress2,
    required this.indiaState,
    required this.indiaPin,
    required this.documentProofIndia,
    required this.ksaAddress1,
    required this.ksaAddress2,
    required this.ksaState,
    required this.ksaPin,
    required this.documentProofKsa,
    required this.vehicleTypeId,
    required this.vehicleNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory SuretiesData.fromJson(Map<String, dynamic> json) => SuretiesData(
        id: json["id"],
        memberId: json["member_id"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profile_image"],
        emailVerifiedAt: json["email_verified_at"],
        verificationStatus: json["verification_status"],
        indiaMobileNumber: json["india_mobile_number"],
        ksaMobileNumber: json["ksa_mobile_number"],
        bloodGroup: json["blood_group"],
        indianAddress1: json["indian_address_1"],
        indianAddress2: json["indian_address_2"],
        indiaState: json["india_state"],
        indiaPin: json["india_pin"],
        documentProofIndia: json["document_proof_india"],
        ksaAddress1: json["ksa_address_1"],
        ksaAddress2: json["ksa_address_2"],
        ksaState: json["ksa_state"],
        ksaPin: json["ksa_pin"],
        documentProofKsa: json["document_proof_ksa"],
        vehicleTypeId: json["vehicle_type_id"],
        vehicleNumber: json["vehicle_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "name": name,
        "email": email,
        "profile_image": profileImage,
        "email_verified_at": emailVerifiedAt,
        "verification_status": verificationStatus,
        "india_mobile_number": indiaMobileNumber,
        "ksa_mobile_number": ksaMobileNumber,
        "blood_group": bloodGroup,
        "indian_address_1": indianAddress1,
        "indian_address_2": indianAddress2,
        "india_state": indiaState,
        "india_pin": indiaPin,
        "document_proof_india": documentProofIndia,
        "ksa_address_1": ksaAddress1,
        "ksa_address_2": ksaAddress2,
        "ksa_state": ksaState,
        "ksa_pin": ksaPin,
        "document_proof_ksa": documentProofKsa,
        "vehicle_type_id": vehicleTypeId,
        "vehicle_number": vehicleNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
