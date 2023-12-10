// To parse this JSON data, do
//
//     final memberDetails = memberDetailsFromJson(jsonString);

import 'dart:convert';

MemberDetails memberDetailsFromJson(String str) =>
    MemberDetails.fromJson(json.decode(str));

String memberDetailsToJson(MemberDetails data) => json.encode(data.toJson());

class MemberDetails {
  bool status;
  Data data;
  String message;
  String accessToken;
  String tokenType;

  MemberDetails({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) => MemberDetails(
        status: json["status"],
        data: Data.fromJson(json["data"]),
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

class Data {
  int id;
  int stateId;
  String name;
  String position;
  String mobile;
  String image;
  String order;
  DateTime createdAt;
  dynamic updatedAt;
  String stateName;

  Data({
    required this.id,
    required this.stateId,
    required this.name,
    required this.position,
    required this.mobile,
    required this.image,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.stateName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        stateId: json["state_id"],
        name: json["name"],
        position: json["position"],
        mobile: json["mobile"],
        image: json["image"],
        order: json["order"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        stateName: json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "name": name,
        "position": position,
        "mobile": mobile,
        "image": image,
        "order": order,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "state_name": stateName,
      };
}
