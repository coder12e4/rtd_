// To parse this JSON data, do
//
//     final getAllStates = getAllStatesFromJson(jsonString);

import 'dart:convert';

GetAllStates getAllStatesFromJson(String str) => GetAllStates.fromJson(json.decode(str));

String getAllStatesToJson(GetAllStates data) => json.encode(data.toJson());

class GetAllStates {
    List<States> data;

    GetAllStates({
        required this.data,
    });

    factory GetAllStates.fromJson(Map<String, dynamic> json) => GetAllStates(
        data: List<States>.from(json["data"].map((x) => States.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class States {
    int id;
    int countryId;
    String stateName;
    dynamic createdAt;
    dynamic updatedAt;

    States({
        required this.id,
        required this.countryId,
        required this.stateName,
        required this.createdAt,
        required this.updatedAt,
    });

    factory States.fromJson(Map<String, dynamic> json) => States(
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
