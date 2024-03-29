class Constants {
  static const String baseUrl = 'http://rtdkerala.com/';
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
  static const String searchBookMember = 'api/user/board-members/list?';
  static const String getServices = 'api/user/service/list';
  static const String getNotification = 'api/user/notification/list';
  static const String seenNotification = 'api/user/notification/mark/seen';
  static const String getActiveLoan = 'api/user/loan/list/active-loans';
  static const String getClosedLoan = 'api/user/loan/list/closed-loans';
  static const String getNotificationPollDetails = 'api/user/vote/view/poll';
  static const String getProfileLoanData = 'api/user/loan/details/show';
  static const String getLonPurpose = 'api/user/purpose/list';
  static const String updateLoanRequest = 'api/user/purpose/list';
  static const String getLoanDocuments = 'api/user/loan/request/documents/list';
  static const String loanRequestComplete = 'api/user/loan/request/completed';
  static const String loanRules = 'loan-rules';
  static const String termsAndConditions = 'terms-and-conditions';
  static const String loanRequestDetails = 'api/user/loan/request/details';
  static const String loanRequestDetailsForSurety =
      'api/user/loan/request/show';
  static const String getBoardMemberDetails =
      'api/user/board-members/show?member_id=';

  static const String removeLoanDocument =
      'api/user/loan/request/document/remove';
  static const String loanRequestDocumentUpload =
      'api/user/loan/request/document/upload';

  static const String uploadLoanDocument =
      'api/user/loan/request/document/upload';
  static const String acceptSuretyRequest =
      'api/user/loan/request/surety/accept';
  static const String rejectSuretyRequest =
      'api/user/loan/request/surety/reject';
  static const String getServiceMemberDetails =
      'api/user/service/member/show?service_member_id=';
  static const String uploadIndianDocument =
      'api/user/profile/ind-document/update';
  static const String uploadKsaDocument =
      'api/user/profile/ksa-document/update';
}
