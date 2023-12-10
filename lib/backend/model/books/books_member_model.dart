// // To parse this JSON data, do
// //
// //     final member = memberFromJson(jsonString);
//
// import 'dart:convert';
//
// Member memberFromJson(String str) => Member.fromJson(json.decode(str));
//
// String memberToJson(Member data) => json.encode(data.toJson());
//
// class Member {
//   bool? status;
//   List<MemberData> data;
//   String message;
//   String accessToken;
//   String tokenType;
//
//   Member({
//     required this.status,
//     required this.data,
//     required this.message,
//     required this.accessToken,
//     required this.tokenType,
//   });
//
//   factory Member.fromJson(Map<String, dynamic> json) => Member(
//         status: json["status"],
//         data: List<MemberData>.from(
//             json["data"].map((x) => MemberData.fromJson(x))),
//         message: json["message"],
//         accessToken: json["access_token"],
//         tokenType: json["token_type"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "message": message,
//         "access_token": accessToken,
//         "token_type": tokenType,
//       };
// }
//
// class MemberData {
//   String name;
//   String? profileImage;
//   String? memberId;
//
//   MemberData({
//     required this.name,
//     required this.profileImage,
//     required this.memberId,
//   });
//
//   factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
//         name: json["name"],
//         profileImage: json["profile_image"],
//         memberId: json["member_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "profile_image": profileImage,
//         "member_id": memberId,
//       };
// }
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

  MemberData({
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

  factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
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
