// // To parse this JSON data, do
// //
// //     final loanData = loanDataFromJson(jsonString);
//
// import 'dart:convert';
//
// LoanData loanDataFromJson(String str) => LoanData.fromJson(json.decode(str));
//
// String loanDataToJson(LoanData data) => json.encode(data.toJson());
//
// class LoanData {
//   bool status;
//   Data? data;
//   String message;
//   String accessToken;
//   String tokenType;
//
//   LoanData({
//     required this.status,
//     required this.data,
//     required this.message,
//     required this.accessToken,
//     required this.tokenType,
//   });
//
//   factory LoanData.fromJson(Map<String, dynamic> json) => LoanData(
//         status: json["status"],
//         data: Data.fromJson(json["data"]),
//         message: json["message"],
//         accessToken: json["access_token"],
//         tokenType: json["token_type"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data?.toJson() ?? null,
//         "message": message,
//         "access_token": accessToken,
//         "token_type": tokenType,
//       };
// }
//
// class Data {
//   int id;
//   int loanRequestId;
//   String fileNumber;
//   int userId;
//   String loanAmount;
//   String paidAmount;
//   DateTime dueDate;
//   DateTime createdAt;
//   String? loanDocument;
//   int status;
//   String loanType;
//   String purpose;
//   User user;
//   String statusText;
//   String startDate;
//   List<Surety> sureties;
//
//   Data({
//     required this.id,
//     required this.loanRequestId,
//     required this.fileNumber,
//     required this.userId,
//     required this.loanAmount,
//     required this.paidAmount,
//     required this.dueDate,
//     required this.createdAt,
//     required this.loanDocument,
//     required this.status,
//     required this.loanType,
//     required this.purpose,
//     required this.user,
//     required this.statusText,
//     required this.startDate,
//     required this.sureties,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         loanRequestId: json["loan_request_id"],
//         fileNumber: json["file_number"],
//         userId: json["user_id"],
//         loanAmount: json["loan_amount"],
//         paidAmount: json["paid_amount"],
//         dueDate: DateTime.parse(json["due_date"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         loanDocument: json["loan_document"],
//         status: json["status"],
//         loanType: json["loan_type"],
//         purpose: json["purpose"],
//         user: User.fromJson(json["user"]),
//         statusText: json["status_text"],
//         startDate: json["start_date"],
//         sureties:
//             List<Surety>.from(json["sureties"].map((x) => Surety.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "loan_request_id": loanRequestId,
//         "file_number": fileNumber,
//         "user_id": userId,
//         "loan_amount": loanAmount,
//         "paid_amount": paidAmount,
//         "due_date":
//             "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
//         "created_at": createdAt.toIso8601String(),
//         "loan_document": loanDocument,
//         "status": status,
//         "loan_type": loanType,
//         "purpose": purpose,
//         "user": user.toJson(),
//         "status_text": statusText,
//         "start_date": startDate,
//         "sureties": List<dynamic>.from(sureties.map((x) => x.toJson())),
//       };
// }
//
// class Surety {
//   int userId;
//   String name;
//   String profileImage;
//   int status;
//   String statusText;
//
//   Surety({
//     required this.userId,
//     required this.name,
//     required this.profileImage,
//     required this.status,
//     required this.statusText,
//   });
//
//   factory Surety.fromJson(Map<String, dynamic> json) => Surety(
//         userId: json["user_id"],
//         name: json["name"],
//         profileImage: json["profile_image"],
//         status: json["status"],
//         statusText: json["status_text"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "name": name,
//         "profile_image": profileImage,
//         "status": status,
//         "status_text": statusText,
//       };
// }
//
// class User {
//   int id;
//   String memberId;
//   String name;
//   String email;
//   String profileImage;
//   dynamic emailVerifiedAt;
//   int verificationStatus;
//   String indiaMobileNumber;
//   String ksaMobileNumber;
//   int bloodGroup;
//   String indianAddress1;
//   String indianAddress2;
//   String indiaState;
//   String indiaPin;
//   String documentProofIndia;
//   String ksaAddress1;
//   String ksaAddress2;
//   int ksaState;
//   String ksaPin;
//   String documentProofKsa;
//   int vehicleTypeId;
//   String vehicleNumber;
//   dynamic fcmToken;
//   DateTime createdAt;
//   DateTime updatedAt;
//   dynamic deletedAt;
//
//   User({
//     required this.id,
//     required this.memberId,
//     required this.name,
//     required this.email,
//     required this.profileImage,
//     required this.emailVerifiedAt,
//     required this.verificationStatus,
//     required this.indiaMobileNumber,
//     required this.ksaMobileNumber,
//     required this.bloodGroup,
//     required this.indianAddress1,
//     required this.indianAddress2,
//     required this.indiaState,
//     required this.indiaPin,
//     required this.documentProofIndia,
//     required this.ksaAddress1,
//     required this.ksaAddress2,
//     required this.ksaState,
//     required this.ksaPin,
//     required this.documentProofKsa,
//     required this.vehicleTypeId,
//     required this.vehicleNumber,
//     required this.fcmToken,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deletedAt,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         memberId: json["member_id"],
//         name: json["name"],
//         email: json["email"],
//         profileImage: json["profile_image"],
//         emailVerifiedAt: json["email_verified_at"],
//         verificationStatus: json["verification_status"],
//         indiaMobileNumber: json["india_mobile_number"],
//         ksaMobileNumber: json["ksa_mobile_number"],
//         bloodGroup: json["blood_group"],
//         indianAddress1: json["indian_address_1"],
//         indianAddress2: json["indian_address_2"],
//         indiaState: json["india_state"],
//         indiaPin: json["india_pin"],
//         documentProofIndia: json["document_proof_india"],
//         ksaAddress1: json["ksa_address_1"],
//         ksaAddress2: json["ksa_address_2"],
//         ksaState: json["ksa_state"],
//         ksaPin: json["ksa_pin"],
//         documentProofKsa: json["document_proof_ksa"],
//         vehicleTypeId: json["vehicle_type_id"],
//         vehicleNumber: json["vehicle_number"],
//         fcmToken: json["fcm_token"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "member_id": memberId,
//         "name": name,
//         "email": email,
//         "profile_image": profileImage,
//         "email_verified_at": emailVerifiedAt,
//         "verification_status": verificationStatus,
//         "india_mobile_number": indiaMobileNumber,
//         "ksa_mobile_number": ksaMobileNumber,
//         "blood_group": bloodGroup,
//         "indian_address_1": indianAddress1,
//         "indian_address_2": indianAddress2,
//         "india_state": indiaState,
//         "india_pin": indiaPin,
//         "document_proof_india": documentProofIndia,
//         "ksa_address_1": ksaAddress1,
//         "ksa_address_2": ksaAddress2,
//         "ksa_state": ksaState,
//         "ksa_pin": ksaPin,
//         "document_proof_ksa": documentProofKsa,
//         "vehicle_type_id": vehicleTypeId,
//         "vehicle_number": vehicleNumber,
//         "fcm_token": fcmToken,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "deleted_at": deletedAt,
//       };
// }
// To parse this JSON data, do
//
//     final loanData = loanDataFromJson(jsonString);

import 'dart:convert';

LoanData loanDataFromJson(String str) => LoanData.fromJson(json.decode(str));

String loanDataToJson(LoanData data) => json.encode(data.toJson());

class LoanData {
  bool status;
  Data? data;
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
        data: Data.fromJson(json["data"]),
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class Data {
  int id;
  int loanRequestId;
  String fileNumber;
  int userId;
  String loanAmount;
  String paidAmount;
  DateTime dueDate;
  DateTime createdAt;
  List<LoanDocument> loanDocument;
  int status;
  String loanType;
  String purpose;
  User user;
  String statusText;
  String startDate;
  List<Surety> sureties;

  Data({
    required this.id,
    required this.loanRequestId,
    required this.fileNumber,
    required this.userId,
    required this.loanAmount,
    required this.paidAmount,
    required this.dueDate,
    required this.createdAt,
    required this.loanDocument,
    required this.status,
    required this.loanType,
    required this.purpose,
    required this.user,
    required this.statusText,
    required this.startDate,
    required this.sureties,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        loanRequestId: json["loan_request_id"],
        fileNumber: json["file_number"],
        userId: json["user_id"],
        loanAmount: json["loan_amount"],
        paidAmount: json["paid_amount"],
        dueDate: DateTime.parse(json["due_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        loanDocument: List<LoanDocument>.from(
            json["loan_document"].map((x) => LoanDocument.fromJson(x))),
        status: json["status"],
        loanType: json["loan_type"],
        purpose: json["purpose"],
        user: User.fromJson(json["user"]),
        statusText: json["status_text"],
        startDate: json["start_date"],
        sureties:
            List<Surety>.from(json["sureties"].map((x) => Surety.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loan_request_id": loanRequestId,
        "file_number": fileNumber,
        "user_id": userId,
        "loan_amount": loanAmount,
        "paid_amount": paidAmount,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "loan_document":
            List<dynamic>.from(loanDocument.map((x) => x.toJson())),
        "status": status,
        "loan_type": loanType,
        "purpose": purpose,
        "user": user.toJson(),
        "status_text": statusText,
        "start_date": startDate,
        "sureties": List<dynamic>.from(sureties.map((x) => x.toJson())),
      };
}

class LoanDocument {
  int id;
  int loanId;
  String filename;
  String ogFileName;
  String type;
  String size;
  DateTime createdAt;
  DateTime updatedAt;
  String file;

  LoanDocument({
    required this.id,
    required this.loanId,
    required this.filename,
    required this.ogFileName,
    required this.type,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
    required this.file,
  });

  factory LoanDocument.fromJson(Map<String, dynamic> json) => LoanDocument(
        id: json["id"],
        loanId: json["loan_id"],
        filename: json["filename"],
        ogFileName: json["og_file_name"],
        type: json["type"],
        size: json["size"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loan_id": loanId,
        "filename": filename,
        "og_file_name": ogFileName,
        "type": type,
        "size": size,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "file": file,
      };
}

class Surety {
  int userId;
  String name;
  String profileImage;
  int status;
  String statusText;

  Surety({
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.status,
    required this.statusText,
  });

  factory Surety.fromJson(Map<String, dynamic> json) => Surety(
        userId: json["user_id"],
        name: json["name"],
        profileImage: json["profile_image"],
        status: json["status"],
        statusText: json["status_text"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "profile_image": profileImage,
        "status": status,
        "status_text": statusText,
      };
}

class User {
  int id;
  String memberId;
  String name;
  String email;
  String profileImage;
  dynamic emailVerifiedAt;
  int verificationStatus;
  int status;
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
  String fcmToken;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  User({
    required this.id,
    required this.memberId,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.emailVerifiedAt,
    required this.verificationStatus,
    required this.status,
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
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        memberId: json["member_id"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profile_image"],
        emailVerifiedAt: json["email_verified_at"],
        verificationStatus: json["verification_status"],
        status: json["status"],
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
        fcmToken: json["fcm_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member_id": memberId,
        "name": name,
        "email": email,
        "profile_image": profileImage,
        "email_verified_at": emailVerifiedAt,
        "verification_status": verificationStatus,
        "status": status,
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
        "fcm_token": fcmToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
