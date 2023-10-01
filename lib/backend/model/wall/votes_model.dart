// To parse this JSON data, do
//
//     final votes = votesFromJson(jsonString);

import 'dart:convert';

Votes votesFromJson(String str) => Votes.fromJson(json.decode(str));

String votesToJson(Votes data) => json.encode(data.toJson());

class Votes {
  bool status;
  List<VotesData> data;
  String message;
  String accessToken;
  String tokenType;

  Votes({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory Votes.fromJson(Map<String, dynamic> json) => Votes(
        status: json["status"],
        data: List<VotesData>.from(
            json["data"].map((x) => VotesData.fromJson(x))),
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

class VotesData {
  int id;
  String title;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  List<Option> options;
  bool activeStatus;
  bool isVoted;

  VotesData({
    required this.id,
    required this.title,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.options,
    required this.activeStatus,
    required this.isVoted,
  });

  factory VotesData.fromJson(Map<String, dynamic> json) => VotesData(
        id: json["id"],
        title: json["title"],
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        activeStatus: json["active_status"],
        isVoted: json["is_voted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "active_status": activeStatus,
        "is_voted": isVoted,
      };
}

class Option {
  int id;
  int voteQuestionId;
  String option;
  DateTime createdAt;
  DateTime updatedAt;

  Option({
    required this.id,
    required this.voteQuestionId,
    required this.option,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        voteQuestionId: json["vote_question_id"],
        option: json["option"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vote_question_id": voteQuestionId,
        "option": option,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
