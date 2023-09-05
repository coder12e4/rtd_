// To parse this JSON data, do
//
//     final getAllStates = getAllStatesFromJson(jsonString);

import 'dart:convert';

GetAllBoodGroup getAllStatesFromJson(String str) => GetAllBoodGroup.fromJson(json.decode(str));

String getAllStatesToJson(GetAllBoodGroup data) => json.encode(data.toJson());

class GetAllBoodGroup {
    List<BloodGroup> data;

    GetAllBoodGroup({
        required this.data,
    });

    factory GetAllBoodGroup.fromJson(Map<String, dynamic> json) => GetAllBoodGroup(
        data: List<BloodGroup>.from(json["data"].map((x) => BloodGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BloodGroup {
    int id;
    String groupName;
    dynamic createdAt;
    dynamic updatedAt;

    BloodGroup({
        required this.id,
        required this.groupName,
        required this.createdAt,
        required this.updatedAt,
    });

    factory BloodGroup.fromJson(Map<String, dynamic> json) => BloodGroup(
        id: json["id"],
        groupName: json["group_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
