// To parse this JSON data, do
//
//     final wallFeedData = wallFeedDataFromJson(jsonString);

import 'dart:convert';

WallFeedData wallFeedDataFromJson(String str) =>
    WallFeedData.fromJson(json.decode(str));

String wallFeedDataToJson(WallFeedData data) => json.encode(data.toJson());

class WallFeedData {
  bool status;
  FeedData data;
  String message;
  String accessToken;
  String tokenType;

  WallFeedData({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory WallFeedData.fromJson(Map<String, dynamic> json) => WallFeedData(
        status: json["status"],
        data: FeedData.fromJson(json["data"]),
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

class FeedData {
  int? currentPage;
  List<Datum> data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int total;

  FeedData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory FeedData.fromJson(Map<String, dynamic> json) => FeedData(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  String fileNumber;
  int userId;
  String loanAmount;
  String paidAmount;
  DateTime dueDate;
  int status;
  User user;
  String statusText;

  Datum({
    required this.fileNumber,
    required this.userId,
    required this.loanAmount,
    required this.paidAmount,
    required this.dueDate,
    required this.status,
    required this.user,
    required this.statusText,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        fileNumber: json["file_number"],
        userId: json["user_id"],
        loanAmount: json["loan_amount"],
        paidAmount: json["paid_amount"],
        dueDate: DateTime.parse(json["due_date"]),
        status: json["status"],
        user: User.fromJson(json["user"]),
        statusText: json["status_text"],
      );

  Map<String, dynamic> toJson() => {
        "file_number": fileNumber,
        "user_id": userId,
        "loan_amount": loanAmount,
        "paid_amount": paidAmount,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "user": user.toJson(),
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
  String? fcmToken;
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

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
