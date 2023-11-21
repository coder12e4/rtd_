// To parse this JSON data, do
//
//     final loanDocument = loanDocumentFromJson(jsonString);

import 'dart:convert';

LoanEditDocument loanDocumentFromJson(String str) =>
    LoanEditDocument.fromJson(json.decode(str));

String loanDocumentToJson(LoanEditDocument data) => json.encode(data.toJson());

class LoanEditDocument {
  bool status;
  List<Documents> data;
  String message;
  String accessToken;
  String tokenType;

  LoanEditDocument({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoanEditDocument.fromJson(Map<String, dynamic> json) =>
      LoanEditDocument(
        status: json["status"],
        data: List<Documents>.from(
            json["data"].map((x) => Documents.fromJson(x))),
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

class Documents {
  int id;
  int loanRequestId;
  String filename;
  String ogFileName;
  String type;
  String size;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String file;

  Documents({
    required this.id,
    required this.loanRequestId,
    required this.filename,
    required this.ogFileName,
    required this.type,
    required this.size,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.file,
  });

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        id: json["id"],
        loanRequestId: json["loan_request_id"],
        filename: json["filename"],
        ogFileName: json["og_file_name"],
        type: json["type"],
        size: json["size"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loan_request_id": loanRequestId,
        "filename": filename,
        "og_file_name": ogFileName,
        "type": type,
        "size": size,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "file": file,
      };
}
