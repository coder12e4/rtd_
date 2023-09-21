// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

import 'dart:convert';

HomeData homeDataFromJson(String str) => HomeData.fromJson(json.decode(str));

String homeDataToJson(HomeData data) => json.encode(data.toJson());

class HomeData {
  bool status;
  Data data;
  String message;

  HomeData({
    required this.status,
    required this.data,
    required this.message,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  GraphData graphData;
  IncomeBreakdown incomeBreakdown;
  List<ActiveLoan> activeLoan;

  Data({
    required this.graphData,
    required this.incomeBreakdown,
    required this.activeLoan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        graphData: GraphData.fromJson(json["graph_data"]),
        incomeBreakdown: IncomeBreakdown.fromJson(json["income_breakdown"]),
        activeLoan: List<ActiveLoan>.from(
            json["active_loan"].map((x) => ActiveLoan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "graph_data": graphData.toJson(),
        "income_breakdown": incomeBreakdown.toJson(),
        "active_loan": List<dynamic>.from(activeLoan.map((x) => x.toJson())),
      };
}

class ActiveLoan {
  int loanId;
  int loanAmount;
  String startDate;
  String endDate;
  String loanType;

  ActiveLoan({
    required this.loanId,
    required this.loanAmount,
    required this.startDate,
    required this.endDate,
    required this.loanType,
  });

  factory ActiveLoan.fromJson(Map<String, dynamic> json) => ActiveLoan(
        loanId: json["loan_id"],
        loanAmount: json["loan_amount"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        loanType: json["loan_type"],
      );

  Map<String, dynamic> toJson() => {
        "loan_id": loanId,
        "loan_amount": loanAmount,
        "start_date": startDate,
        "end_date": endDate,
        "loan_type": loanType,
      };
}

class GraphData {
  int userId;
  String userName;
  int graphCount;
  int totalCollection;
  int balance;

  GraphData({
    required this.userId,
    required this.userName,
    required this.graphCount,
    required this.totalCollection,
    required this.balance,
  });

  factory GraphData.fromJson(Map<String, dynamic> json) => GraphData(
        userId: json["user_id"],
        userName: json["user_name"],
        graphCount: json["graph_count"],
        totalCollection: json["total_collection"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "graph_count": graphCount,
        "total_collection": totalCollection,
        "balance": balance,
      };
}

class IncomeBreakdown {
  String typeOfJob;
  int memebershipAmound;
  int activeLoans;
  int closedLoans;

  IncomeBreakdown({
    required this.typeOfJob,
    required this.memebershipAmound,
    required this.activeLoans,
    required this.closedLoans,
  });

  factory IncomeBreakdown.fromJson(Map<String, dynamic> json) =>
      IncomeBreakdown(
        typeOfJob: json["type_of_job"],
        memebershipAmound: json["memebership_amound"],
        activeLoans: json["active_loans"],
        closedLoans: json["closed_loans"],
      );

  Map<String, dynamic> toJson() => {
        "type_of_job": typeOfJob,
        "memebership_amound": memebershipAmound,
        "active_loans": activeLoans,
        "closed_loans": closedLoans,
      };
}
