// To parse this JSON data, do
//
//     final getAllStates = getAllStatesFromJson(jsonString);

import 'dart:convert';

GetAllStates getAllStatesFromJson(String str) => GetAllStates.fromJson(json.decode(str));

String getAllStatesToJson(GetAllStates data) => json.encode(data.toJson());

class GetAllStates {
    List<AllStatesModel> data;

    GetAllStates({
        required this.data,
    });

    factory GetAllStates.fromJson(Map<String, dynamic> json) => GetAllStates(
        data: List<AllStatesModel>.from(json["data"].map((x) => AllStatesModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AllStatesModel {
    int id;
    int countryId;
    String stateName;
    dynamic createdAt;
    dynamic updatedAt;

    AllStatesModel({
        required this.id,
        required this.countryId,
        required this.stateName,
        required this.createdAt,
        required this.updatedAt,
    });

    factory AllStatesModel.fromJson(Map<String, dynamic> json) => AllStatesModel(
        id: json["id"],
        countryId: json["country_id"],
        stateName: json["state_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "state_name": stateName,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
