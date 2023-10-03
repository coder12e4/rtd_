class Constants {
  static const String baseUrl = 'http://rtd.canisostudio.com/';
  static const String register = 'api/register';
  static const String login = 'api/user/login';
  static const String getStates = 'api/get_states?country_id=';
  // static const String getKsaStates = 'api/get_states?country_id=2';
  static const String getAllBloodGroup = 'api/get_blood_groups';
  static const String getAllElectedMembers = 'api/user/board-members/list';
  static const String getUserDetails = 'api/user/details';
  static const String updateProfile = 'api/user/update';
  static const String getVehicleType = 'api/vehicle-types';
  static const String loanType = 'api/user/loan-type/list';
  static const String loanSurties = 'api/user/sureties/list';
  static const String cancelLoanRequest = 'api/user/loan/request/cancel';
  static const String getLoanRequest = 'api/user/loan/request/list';
  static const String getHomeData = 'api/user/home';
  static const String loanRequestEdit = 'api/user/loan/request/edit';
  static const String getWallFeedData = 'api/user/wall/feeds';
  static const String getWallVotesData = 'api/user/vote/list/questions';
  static const String submitVote = 'api/user/vote/submit/option';
  static const String searchBookMember = 'api/user/search';
  static const String uploadIndianDocument =
      'api/user/profile/ind-document/update';
  static const String uploadKsaDocument =
      'api/user/profile/ksa-document/update';
}
