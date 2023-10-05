// To parse this JSON data, do
//
//     final member = memberFromJson(jsonString);

import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  bool status;
  List<MemberData> data;
  String message;
  String accessToken;
  String tokenType;

  Member({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        status: json["status"],
        data: List<MemberData>.from(
            json["data"].map((x) => MemberData.fromJson(x))),
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

class MemberData {
  String name;
  String profileImage;
  String memberId;

  MemberData({
    required this.name,
    required this.profileImage,
    required this.memberId,
  });

  factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
        name: json["name"],
        profileImage: json["profile_image"],
        memberId: json["member_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profile_image": profileImage,
        "member_id": memberId,
      };
}
