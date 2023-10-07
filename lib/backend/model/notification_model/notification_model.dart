// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  bool status;
  List<NotificationDetails> data;
  String message;
  String accessToken;
  String tokenType;

  Notification({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        status: json["status"],
        data: List<NotificationDetails>.from(
            json["data"].map((x) => NotificationDetails.fromJson(x))),
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

class NotificationDetails {
  int id;
  String date;
  String message;
  int type;
  String sender;
  String receiver;
  Details details;
  int seen;

  NotificationDetails({
    required this.id,
    required this.date,
    required this.message,
    required this.type,
    required this.sender,
    required this.receiver,
    required this.details,
    required this.seen,
  });

  factory NotificationDetails.fromJson(Map<String, dynamic> json) =>
      NotificationDetails(
        id: json["id"],
        date: json["date"],
        message: json["message"],
        type: json["type"],
        sender: json["sender"],
        receiver: json["receiver"],
        details: Details.fromJson(json["details"]),
        seen: json["seen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "message": message,
        "type": type,
        "sender": sender,
        "receiver": receiver,
        "details": details.toJson(),
        "seen": seen,
      };
}

class Details {
  int id;
  String? amount;
  String? purpose;
  int? status;
  String? title;
  DateTime? endDate;

  Details({
    required this.id,
    this.amount,
    this.purpose,
    this.status,
    this.title,
    this.endDate,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        amount: json["amount"],
        purpose: json["purpose"],
        status: json["status"],
        title: json["title"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "purpose": purpose,
        "status": status,
        "title": title,
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
      };
}
