// To parse this JSON data, do
//
//     final loanPurpose = loanPurposeFromJson(jsonString);

import 'dart:convert';

LoanPurpose loanPurposeFromJson(String str) =>
    LoanPurpose.fromJson(json.decode(str));

String loanPurposeToJson(LoanPurpose data) => json.encode(data.toJson());

class LoanPurpose {
  bool status;
  List<PurposeData> data;
  String message;
  String accessToken;
  String tokenType;

  LoanPurpose({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoanPurpose.fromJson(Map<String, dynamic> json) => LoanPurpose(
        status: json["status"],
        data: List<PurposeData>.from(
            json["data"].map((x) => PurposeData.fromJson(x))),
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

class PurposeData {
  int id;
  int loanTypeId;
  String purpose;
  String maxLimit;
  int noOfSureties;
  DateTime createdAt;
  DateTime updatedAt;

  PurposeData({
    required this.id,
    required this.loanTypeId,
    required this.purpose,
    required this.maxLimit,
    required this.noOfSureties,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PurposeData.fromJson(Map<String, dynamic> json) => PurposeData(
        id: json["id"],
        loanTypeId: json["loan_type_id"],
        purpose: json["purpose"],
        maxLimit: json["max_limit"],
        noOfSureties: json["no_of_sureties"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loan_type_id": loanTypeId,
        "purpose": purpose,
        "max_limit": maxLimit,
        "no_of_sureties": noOfSureties,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
