// To parse this JSON data, do
//
//     final loanRequestDetails = loanRequestDetailsFromJson(jsonString);

import 'dart:convert';

LoanRequestDetails loanRequestDetailsFromJson(String str) =>
    LoanRequestDetails.fromJson(json.decode(str));

String loanRequestDetailsToJson(LoanRequestDetails data) =>
    json.encode(data.toJson());

class LoanRequestDetails {
  bool status;
  RequestDetails data;
  String message;
  String accessToken;
  String tokenType;

  LoanRequestDetails({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoanRequestDetails.fromJson(Map<String, dynamic> json) =>
      LoanRequestDetails(
        status: json["status"],
        data: RequestDetails.fromJson(json["data"]),
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

class RequestDetails {
  int id;
  int userId;
  int loanTypeId;
  int loanPurposeId;
  String loanAmount;
  List<LoanDocument> loanDocument;
  dynamic rejectReason;
  int status;
  int requestStatus;
  DateTime createdAt;
  DateTime updatedAt;
  LoanType loanType;
  LoanPurpose? loanPurpose;
  List<Surety> sureties;
  RequestedUser requestedUser;
  String? statusText;
  String? createdDate;

  RequestDetails({
    required this.id,
    required this.userId,
    required this.loanTypeId,
    required this.loanPurposeId,
    required this.loanAmount,
    required this.loanDocument,
    required this.rejectReason,
    required this.status,
    required this.requestStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.loanType,
    required this.loanPurpose,
    required this.sureties,
    required this.requestedUser,
    required this.statusText,
    required this.createdDate,
  });

  factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
        id: json["id"],
        userId: json["user_id"],
        loanTypeId: json["loan_type_id"],
        loanPurposeId: json["loan_purpose_id"],
        loanAmount: json["loan_amount"],
        loanDocument: List<LoanDocument>.from(
            json["loan_document"].map((x) => LoanDocument.fromJson(x))),
        rejectReason: json["reject_reason"],
        status: json["status"],
        requestStatus: json["request_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        loanType: LoanType.fromJson(json["loan_type"]),
        loanPurpose: json["loan_purpose"] != null
            ? LoanPurpose.fromJson(json["loan_purpose"])
            : null,
        sureties:
            List<Surety>.from(json["sureties"].map((x) => Surety.fromJson(x))),
        requestedUser: RequestedUser.fromJson(json["requested_user"]),
        statusText: json["status_text"],
        createdDate: json["created_date"],
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
        "request_status": requestStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "loan_type": loanType.toJson(),
        "loan_purpose": loanPurpose?.toJson(),
        "sureties": List<dynamic>.from(sureties.map((x) => x.toJson())),
        "requested_user": requestedUser.toJson(),
        "status_text": statusText,
        "created_date": createdDate,
      };
}

class LoanDocument {
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
  String allottedAmount;
  String balanceAmount;
  DateTime createdAt;
  DateTime updatedAt;

  LoanType({
    required this.id,
    required this.title,
    required this.allottedAmount,
    required this.balanceAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoanType.fromJson(Map<String, dynamic> json) => LoanType(
        id: json["id"],
        title: json["title"],
        allottedAmount: json["allotted_amount"],
        balanceAmount: json["balance_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "allotted_amount": allottedAmount,
        "balance_amount": balanceAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class RequestedUser {
  int id;
  String memberId;
  String name;
  String email;
  String fcmToken;
  String profileImage;
  dynamic emailVerifiedAt;
  String indiaMobileNumber;
  String ksaMobileNumber;
  int bloodGroup;
  String indianAddress1;
  String indianAddress2;
  String indiaState;
  String indiaPin;
  String documentProofIndia;
  String ksaAddress1;
  String ksaAddress2;
  int ksaState;
  String ksaPin;
  String documentProofKsa;
  int vehicleTypeId;
  String vehicleNumber;
  DateTime? memberSince;
  int verificationStatus;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  RequestedUser({
    required this.id,
    required this.memberId,
    required this.name,
    required this.email,
    required this.fcmToken,
    required this.profileImage,
    required this.emailVerifiedAt,
    required this.indiaMobileNumber,
    required this.ksaMobileNumber,
    required this.bloodGroup,
    required this.indianAddress1,
    required this.indianAddress2,
    required this.indiaState,
    required this.indiaPin,
    required this.documentProofIndia,
    required this.ksaAddress1,
    required this.ksaAddress2,
    required this.ksaState,
    required this.ksaPin,
    required this.documentProofKsa,
    required this.vehicleTypeId,
    required this.vehicleNumber,
    this.memberSince,
    required this.verificationStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory RequestedUser.fromJson(Map<String, dynamic> json) => RequestedUser(
        id: json["id"],
        memberId: json["member_id"],
        name: json["name"],
        email: json["email"],
        fcmToken: json["fcm_token"],
        profileImage: json["profile_image"],
        emailVerifiedAt: json["email_verified_at"],
        indiaMobileNumber: json["india_mobile_number"],
        ksaMobileNumber: json["ksa_mobile_number"],
        bloodGroup: json["blood_group"],
        indianAddress1: json["indian_address_1"],
        indianAddress2: json["indian_address_2"],
        indiaState: json["india_state"],
        indiaPin: json["india_pin"],
        documentProofIndia: json["document_proof_india"],
        ksaAddress1: json["ksa_address_1"],
        ksaAddress2: json["ksa_address_2"],
        ksaState: json["ksa_state"],
        ksaPin: json["ksa_pin"],
        documentProofKsa: json["document_proof_ksa"],
        vehicleTypeId: json["vehicle_type_id"],
        vehicleNumber: json["vehicle_number"],
        memberSince: json["member_since"] != null
            ? DateTime.parse(json["member_since"])
            : null,
        verificationStatus: json["verification_status"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "name": name,
        "email": email,
        "fcm_token": fcmToken,
        "profile_image": profileImage,
        "email_verified_at": emailVerifiedAt,
        "india_mobile_number": indiaMobileNumber,
        "ksa_mobile_number": ksaMobileNumber,
        "blood_group": bloodGroup,
        "indian_address_1": indianAddress1,
        "indian_address_2": indianAddress2,
        "india_state": indiaState,
        "india_pin": indiaPin,
        "document_proof_india": documentProofIndia,
        "ksa_address_1": ksaAddress1,
        "ksa_address_2": ksaAddress2,
        "ksa_state": ksaState,
        "ksa_pin": ksaPin,
        "document_proof_ksa": documentProofKsa,
        "vehicle_type_id": vehicleTypeId,
        "vehicle_number": vehicleNumber,
        "member_since":
            "${memberSince?.year.toString().padLeft(4, '0')}-${memberSince?.month.toString().padLeft(2, '0')}-${memberSince?.day.toString().padLeft(2, '0')}",
        "verification_status": verificationStatus,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
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
