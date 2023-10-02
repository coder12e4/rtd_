class UserData {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  int? verificationStatus;
  String? indiaMobileNumber;
  String? ksaMobileNumber;
  int? bloodGroup;
  String? indianAddress1;
  String? indianAddress2;
  String? indiaState;
  String? indiaPin;
  String? documentProofIndia;
  String? ksaAddress1;
  String? ksaAddress2;
  int? ksaState;
  String? ksaPin;
  String? documentProofKsa;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.verificationStatus,
      this.indiaMobileNumber,
      this.ksaMobileNumber,
      this.bloodGroup,
      this.indianAddress1,
      this.indianAddress2,
      this.indiaState,
      this.indiaPin,
      this.documentProofIndia,
      this.ksaAddress1,
      this.ksaAddress2,
      this.ksaState,
      this.ksaPin,
      this.documentProofKsa,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    verificationStatus = json['verification_status'];
    indiaMobileNumber = json['india_mobile_number'];
    ksaMobileNumber = json['ksa_mobile_number'];
    bloodGroup = json['blood_group'];
    indianAddress1 = json['indian_address_1'];
    indianAddress2 = json['indian_address_2'];
    indiaState = json['india_state'];
    indiaPin = json['india_pin'];
    documentProofIndia = json['document_proof_india'];
    ksaAddress1 = json['ksa_address_1'];
    ksaAddress2 = json['ksa_address_2'];
    ksaState = json['ksa_state'];
    ksaPin = json['ksa_pin'];
    documentProofKsa = json['document_proof_ksa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['verification_status'] = verificationStatus;
    data['india_mobile_number'] = indiaMobileNumber;
    data['ksa_mobile_number'] = ksaMobileNumber;
    data['blood_group'] = bloodGroup;
    data['indian_address_1'] = indianAddress1;
    data['indian_address_2'] = indianAddress2;
    data['india_state'] = indiaState;
    data['india_pin'] = indiaPin;
    data['document_proof_india'] = documentProofIndia;
    data['ksa_address_1'] = ksaAddress1;
    data['ksa_address_2'] = ksaAddress2;
    data['ksa_state'] = ksaState;
    data['ksa_pin'] = ksaPin;
    data['document_proof_ksa'] = documentProofKsa;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
