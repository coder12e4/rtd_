import 'dart:convert';

HomeData homeDataFromJson(String str) => HomeData.fromJson(json.decode(str));

String homeDataToJson(HomeData data) => json.encode(data.toJson());

class HomeData {
  int totalCollectionAmount;
  int totalAmountBalance;
  Income income;
  Loans loans;
  ActiveLoan activeLoan;

  HomeData({
    required this.totalCollectionAmount,
    required this.totalAmountBalance,
    required this.income,
    required this.loans,
    required this.activeLoan,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        totalCollectionAmount: json["total_collection_amount"],
        totalAmountBalance: json["total_amount_balance"],
        income: Income.fromJson(json["income"]),
        loans: Loans.fromJson(json["loans"]),
        activeLoan: ActiveLoan.fromJson(json["active_loan"]),
      );

  Map<String, dynamic> toJson() => {
        "total_collection_amount": totalCollectionAmount,
        "total_amount_balance": totalAmountBalance,
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
