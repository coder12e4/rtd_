class Notification {
  bool? status;
  List<NotificationDetails>? data;
  String? message;
  String? accessToken;
  String? tokenType;

  Notification(
      {this.status, this.data, this.message, this.accessToken, this.tokenType});

  Notification.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NotificationDetails>[];
      json['data'].forEach((v) {
        data!.add(NotificationDetails.fromJson(v));
      });
    }
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    return data;
  }
}

class NotificationDetails {
  int? id;
  String? date;
  String? message;
  int? type;
  String? sender;
  String? receiver;
  Details? details;
  int? seen;

  NotificationDetails(
      {this.id,
      this.date,
      this.message,
      this.type,
      this.sender,
      this.receiver,
      this.details,
      this.seen});

  NotificationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    message = json['message'];
    type = json['type'];
    sender = json['sender'];
    receiver = json['receiver'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['message'] = message;
    data['type'] = type;
    data['sender'] = sender;
    data['receiver'] = receiver;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    data['seen'] = seen;
    return data;
  }
}

class Details {
  int? id;
  String? amount;
  String? paidAmount;
  String? dueDate;
  String? purpose;
  int? status;

  Details(
      {this.id,
      this.amount,
      this.paidAmount,
      this.dueDate,
      this.purpose,
      this.status});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    paidAmount = json['paid_amount'];
    dueDate = json['due_date'];
    purpose = json['purpose'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['paid_amount'] = paidAmount;
    data['due_date'] = dueDate;
    data['purpose'] = purpose;
    data['status'] = status;
    return data;
  }
}
