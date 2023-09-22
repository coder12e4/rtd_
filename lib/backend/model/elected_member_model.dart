// To parse this JSON data, do
//
//     final electedMember = electedMemberFromJson(jsonString);

import 'dart:convert';

ElectedMember electedMemberFromJson(String str) => ElectedMember.fromJson(json.decode(str));

String electedMemberToJson(ElectedMember data) => json.encode(data.toJson());

class ElectedMember {
  bool status;
  List<ElectedMemberData> data;
  String message;
  String accessToken;
  String tokenType;

  ElectedMember({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory ElectedMember.fromJson(Map<String, dynamic> json) => ElectedMember(
    status: json["status"],
    data: List<ElectedMemberData>.from(json["data"].map((x) => ElectedMemberData.fromJson(x))),
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

class ElectedMemberData {
  int id;
  String name;
  String position;
  String mobile;
  String image;
  String order;
  DateTime createdAt;
  dynamic updatedAt;

  ElectedMemberData({
    required this.id,
    required this.name,
    required this.position,
    required this.mobile,
    required this.image,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ElectedMemberData.fromJson(Map<String, dynamic> json) => ElectedMemberData(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    mobile: json["mobile"],
    image: json["image"],
    order: json["order"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "position": position,
    "mobile": mobile,
    "image": image,
    "order": order,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}
