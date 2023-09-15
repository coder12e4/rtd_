class HomeData {
  bool? status;
  Data? data;
  String? message;

  HomeData({this.status, this.data, this.message});

  HomeData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  GraphData? graphData;
  IncomeBreakdown? incomeBreakdown;
  List<ActiveLoan>? activeLoan;

  Data({this.graphData, this.incomeBreakdown, this.activeLoan});

  Data.fromJson(Map<String, dynamic> json) {
    graphData = json['graph_data'] != null
        ? GraphData.fromJson(json['graph_data'])
        : null;
    incomeBreakdown = json['income_breakdown'] != null
        ? IncomeBreakdown.fromJson(json['income_breakdown'])
        : null;
    if (json['active_loan'] != null) {
      activeLoan = <ActiveLoan>[];
      json['active_loan'].forEach((v) {
        activeLoan!.add(ActiveLoan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (graphData != null) {
      data['graph_data'] = graphData!.toJson();
    }
    if (incomeBreakdown != null) {
      data['income_breakdown'] = incomeBreakdown!.toJson();
    }
    if (activeLoan != null) {
      data['active_loan'] = activeLoan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraphData {
  int? userId;
  String? userName;
  int? graphCount;
  int? totalCollection;
  int? balance;

  GraphData(
      {this.userId,
      this.userName,
      this.graphCount,
      this.totalCollection,
      this.balance});

  GraphData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    graphCount = json['graph_count'];
    totalCollection = json['total_collection'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['graph_count'] = graphCount;
    data['total_collection'] = totalCollection;
    data['balance'] = balance;
    return data;
  }
}

class IncomeBreakdown {
  String? typeOfJob;
  int? memebershipAmound;
  int? activeLoans;
  int? closedLoans;

  IncomeBreakdown(
      {this.typeOfJob,
      this.memebershipAmound,
      this.activeLoans,
      this.closedLoans});

  IncomeBreakdown.fromJson(Map<String, dynamic> json) {
    typeOfJob = json['type_of_job'];
    memebershipAmound = json['memebership_amound'];
    activeLoans = json['active_loans'];
    closedLoans = json['closed_loans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type_of_job'] = typeOfJob;
    data['memebership_amound'] = memebershipAmound;
    data['active_loans'] = activeLoans;
    data['closed_loans'] = closedLoans;
    return data;
  }
}

class ActiveLoan {
  int? loanId;
  int? loanAmount;
  String? startDate;
  String? endDate;
  String? loanType;

  ActiveLoan(
      {this.loanId,
      this.loanAmount,
      this.startDate,
      this.endDate,
      this.loanType});

  ActiveLoan.fromJson(Map<String, dynamic> json) {
    loanId = json['loan_id'];
    loanAmount = json['loan_amount'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    loanType = json['loan_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['loan_id'] = loanId;
    data['loan_amount'] = loanAmount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['loan_type'] = loanType;
    return data;
  }
}
