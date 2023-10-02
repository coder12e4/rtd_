import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  bool status;
  Data data;
  String message;
  String accessToken;
  String tokenType;

  Profile({
    required this.status,
    required this.data,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        status: json["status"],
        data: Data.fromJson(json["data"]),
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

class Data {
  int id;
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
  AState indiaState;
  String indiaPin;
  String documentProofIndia;
  String ksaAddress1;
  String ksaAddress2;
  AState ksaState;
  String ksaPin;
  String documentProofKsa;
  dynamic vehicleTypeId;
  dynamic vehicleNumber;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Data({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
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
        indiaState: AState.fromJson(json["india_state"]),
        indiaPin: json["india_pin"],
        documentProofIndia: json["document_proof_india"],
        ksaAddress1: json["ksa_address_1"],
        ksaAddress2: json["ksa_address_2"],
        ksaState: AState.fromJson(json["ksa_state"]),
        ksaPin: json["ksa_pin"],
        documentProofKsa: json["document_proof_ksa"],
        vehicleTypeId: json["vehicle_type_id"],
        vehicleNumber: json["vehicle_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "india_state": indiaState.toJson(),
        "india_pin": indiaPin,
        "document_proof_india": documentProofIndia,
        "ksa_address_1": ksaAddress1,
        "ksa_address_2": ksaAddress2,
        "ksa_state": ksaState.toJson(),
        "ksa_pin": ksaPin,
        "document_proof_ksa": documentProofKsa,
        "vehicle_type_id": vehicleTypeId,
        "vehicle_number": vehicleNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class AState {
  int id;
  int countryId;
  String stateName;
  dynamic createdAt;
  dynamic updatedAt;

  AState({
    required this.id,
    required this.countryId,
    required this.stateName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AState.fromJson(Map<String, dynamic> json) => AState(
        id: json["id"],
        countryId: json["country_id"],
        stateName: json["state_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "state_name": stateName,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
