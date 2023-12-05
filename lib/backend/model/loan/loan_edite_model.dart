// To parse this JSON data, do
//
//     final loanData = loanDataFromJson(jsonString);

import 'dart:convert';

LoanData loanDataFromJson(String str) => LoanData.fromJson(json.decode(str));

String loanDataToJson(LoanData data) => json.encode(data.toJson());

class LoanData {
  bool status;
  EditData data;
  String message;
  String accessToken;
  String tokenType;

  LoanData({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoanData.fromJson(Map<String, dynamic> json) => LoanData(
        status: json["status"],
        data: EditData.fromJson(json["data"]),
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

class EditData {
  int id;
  int userId;
  int loanTypeId;
  int loanPurposeId;
  String loanAmount;
  List<LoanDocument> loanDocument;
  dynamic rejectReason;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  LoanType loanType;
  LoanPurpose loanPurpose;
  List<Surety> sureties;

  EditData({
    required this.id,
    required this.userId,
    required this.loanTypeId,
    required this.loanPurposeId,
    required this.loanAmount,
    required this.loanDocument,
    required this.rejectReason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.loanType,
    required this.loanPurpose,
    required this.sureties,
  });

  factory EditData.fromJson(Map<String, dynamic> json) => EditData(
        id: json["id"],
        userId: json["user_id"],
        loanTypeId: json["loan_type_id"],
        loanPurposeId: json["loan_purpose_id"],
        loanAmount: json["loan_amount"],
        loanDocument: List<LoanDocument>.from(
            json["loan_document"].map((x) => LoanDocument.fromJson(x))),
        rejectReason: json["reject_reason"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        loanType: LoanType.fromJson(json["loan_type"]),
        loanPurpose: LoanPurpose.fromJson(json["loan_purpose"]),
        sureties:
            List<Surety>.from(json["sureties"].map((x) => Surety.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "loan_type_id": loanTypeId,
        "loan_purpose_id": loanPurposeId,
        "loan_amount": loanAmount,
        "loan_document":
            List<dynamic>.from(loanDocument.map((x) => x.toJson())),
        "reject_reason": rejectReason,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "loan_type": loanType.toJson(),
        "loan_purpose": loanPurpose.toJson(),
        "sureties": List<dynamic>.from(sureties.map((x) => x.toJson())),
      };
}

class LoanDocument {
  int? id;
  int? loanRequestId;
  String? filename;
  String? ogFileName;
  String? type;
  String? size;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? file;

  LoanDocument({
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

  factory LoanDocument.fromJson(Map<String, dynamic> json) => LoanDocument(
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "file": file,
      };
}

class LoanPurpose {
  int id;
  int loanTypeId;
  String purpose;
  String maxLimit;
  int noOfSureties;
  DateTime createdAt;
  DateTime updatedAt;

  LoanPurpose({
    required this.id,
    required this.loanTypeId,
    required this.purpose,
    required this.maxLimit,
    required this.noOfSureties,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoanPurpose.fromJson(Map<String, dynamic> json) => LoanPurpose(
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

class LoanType {
  int id;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  LoanType({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoanType.fromJson(Map<String, dynamic> json) => LoanType(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Surety {
  int id;
  String name;
  String profileImage;
  int status;
  String statusText;

  Surety({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.status,
    required this.statusText,
  });

  factory Surety.fromJson(Map<String, dynamic> json) => Surety(
        id: json["id"],
        name: json["name"],
        profileImage: json["profile_image"],
        status: json["status"],
        statusText: json["status_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_image": profileImage,
        "status": status,
        "status_text": statusText,
      };
}
