// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

import 'dart:convert';

HomeData homeDataFromJson(String str) => HomeData.fromJson(json.decode(str));

String homeDataToJson(HomeData data) => json.encode(data.toJson());

class HomeData {
  List<CollectionSummary> collectionSummary;
  Income income;
  Loans loans;
  ActiveLoan activeLoan;

  HomeData({
    required this.collectionSummary,
    required this.income,
    required this.loans,
    required this.activeLoan,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        collectionSummary: List<CollectionSummary>.from(
            json["collection_summary"]
                .map((x) => CollectionSummary.fromJson(x))),
        income: Income.fromJson(json["income"]),
        loans: Loans.fromJson(json["loans"]),
        activeLoan: ActiveLoan.fromJson(json["active_loan"]),
      );

  Map<String, dynamic> toJson() => {
        "collection_summary":
            List<dynamic>.from(collectionSummary.map((x) => x.toJson())),
        "income": income.toJson(),
        "loans": loans.toJson(),
        "active_loan": activeLoan.toJson(),
      };
}

class ActiveLoan {
  int loanAmount;
  String startDate;
  String loanType;

  ActiveLoan({
    required this.loanAmount,
    required this.startDate,
    required this.loanType,
  });

  factory ActiveLoan.fromJson(Map<String, dynamic> json) => ActiveLoan(
        loanAmount: json["loan_amount"],
        startDate: json["start_date"],
        loanType: json["Loan Type"],
      );

  Map<String, dynamic> toJson() => {
        "loan_amount": loanAmount,
        "start_date": startDate,
        "Loan Type": loanType,
      };
}

class CollectionSummary {
  String title;
  List<AmountSummary> amountSummary;

  CollectionSummary({
    required this.title,
    required this.amountSummary,
  });

  factory CollectionSummary.fromJson(Map<String, dynamic> json) =>
      CollectionSummary(
        title: json["title"],
        amountSummary: List<AmountSummary>.from(
            json["amount_summary"].map((x) => AmountSummary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount_summary":
            List<dynamic>.from(amountSummary.map((x) => x.toJson())),
      };
}

class AmountSummary {
  String title;
  int amount;

  AmountSummary({
    required this.title,
    required this.amount,
  });

  factory AmountSummary.fromJson(Map<String, dynamic> json) => AmountSummary(
        title: json["title"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
      };
}

class Income {
  int truck;
  int membership;

  Income({
    required this.truck,
    required this.membership,
  });

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        truck: json["truck"],
        membership: json["membership"],
      );

  Map<String, dynamic> toJson() => {
        "truck": truck,
        "membership": membership,
      };
}

class Loans {
  int active;
  int closed;

  Loans({
    required this.active,
    required this.closed,
  });

  factory Loans.fromJson(Map<String, dynamic> json) => Loans(
        active: json["active"],
        closed: json["closed"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "closed": closed,
      };
}
