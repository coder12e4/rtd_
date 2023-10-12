// To parse this JSON data, do
//
//     final pollDetails = pollDetailsFromJson(jsonString);

import 'dart:convert';

PollDetails pollDetailsFromJson(String str) =>
    PollDetails.fromJson(json.decode(str));

String pollDetailsToJson(PollDetails data) => json.encode(data.toJson());

class PollDetails {
  bool status;
  PollData data;
  String message;
  String accessToken;
  String tokenType;

  PollDetails({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory PollDetails.fromJson(Map<String, dynamic> json) => PollDetails(
        status: json["status"],
        data: PollData.fromJson(json["data"]),
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

class PollData {
  int id;
  String title;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  List<Option> options;
  bool activeStatus;
  bool isVoted;

  PollData({
    required this.id,
    required this.title,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.options,
    required this.activeStatus,
    required this.isVoted,
  });

  factory PollData.fromJson(Map<String, dynamic> json) => PollData(
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
