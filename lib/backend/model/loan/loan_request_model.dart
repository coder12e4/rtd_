import 'dart:convert';

LoanRequestData loanRequestDataFromJson(String str) =>
    LoanRequestData.fromJson(json.decode(str));

String loanRequestDataToJson(LoanRequestData data) =>
    json.encode(data.toJson());

class LoanRequestData {
  bool status;
  List<LoanData> data;
  String message;
  String accessToken;
  String tokenType;

  LoanRequestData({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoanRequestData.fromJson(Map<String, dynamic> json) =>
      LoanRequestData(
        status: json["status"],
        data:
            List<LoanData>.from(json["data"].map((x) => LoanData.fromJson(x))),
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

class LoanData {
  int id;
  String loanAmount;
  DateTime createdAt;
  int status;
  String statusText;
  List<Surety> sureties;

  LoanData({
    required this.id,
    required this.loanAmount,
    required this.createdAt,
    required this.status,
    required this.statusText,
    required this.sureties,
  });

  factory LoanData.fromJson(Map<String, dynamic> json) => LoanData(
        id: json["id"],
        loanAmount: json["loan_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        statusText: json["status_text"],
        sureties:
            List<Surety>.from(json["sureties"].map((x) => Surety.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loan_amount": loanAmount,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "status_text": statusText,
        "sureties": List<dynamic>.from(sureties.map((x) => x.toJson())),
      };
}

class Surety {
  int userId;
  Name name;
  String profileImage;
  int status;
  StatusText statusText;

  Surety({
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.status,
    required this.statusText,
  });

  factory Surety.fromJson(Map<String, dynamic> json) => Surety(
        userId: json["user_id"],
        name: nameValues.map[json["name"]]!,
        profileImage: json["profile_image"],
        status: json["status"],
        statusText: statusTextValues.map[json["status_text"]]!,
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": nameValues.reverse[name],
        "profile_image": profileImage,
        "status": status,
        "status_text": statusTextValues.reverse[statusText],
      };
}

enum Name { BOBY, JAMSHEER, TEST, TEST_USER_10 }

final nameValues = EnumValues({
  "Boby": Name.BOBY,
  "jamsheer": Name.JAMSHEER,
  "test": Name.TEST,
  "test user 10": Name.TEST_USER_10
});

enum StatusText { PENDING }

final statusTextValues = EnumValues({"Pending": StatusText.PENDING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
