import 'package:get/get.dart';
import 'package:rtd_project/backend/binding/auth/login_binding.dart';
import 'package:rtd_project/backend/binding/auth/register_binding.dart';
import 'package:rtd_project/backend/binding/book/board_member_details_binding.dart';
import 'package:rtd_project/backend/binding/book/service_member_details_bindig.dart';
import 'package:rtd_project/backend/binding/bottom_navigation_binding.dart';
import 'package:rtd_project/backend/binding/elected_member_binding.dart';
import 'package:rtd_project/backend/binding/loan/loan_screen_binding.dart';
import 'package:rtd_project/backend/binding/notification/surety_view_binding.dart';
import 'package:rtd_project/backend/binding/search_screen_binding.dart';
import 'package:rtd_project/backend/binding/splash_binding.dart';
import 'package:rtd_project/view/book_screen/elected_member_screen/elected_member_screen.dart';
import 'package:rtd_project/view/login_screen/login_page.dart';
import 'package:rtd_project/view/profile_screen/profile_edit_screen/profile_edit_screen.dart';
import 'package:rtd_project/view/profile_screen/profile_page.dart';
import 'package:rtd_project/view/register_screen/register_screen.dart';
import 'package:rtd_project/view/search_page/search_screen.dart';
import 'package:rtd_project/view/splash_screen/splash_page.dart';

import '../backend/binding/edit_profile_binding.dart';
import '../backend/binding/loan/loan_details_binding.dart';
import '../backend/binding/loan/loan_edit_binding.dart';
import '../backend/binding/loan/profie_loan_data_binding.dart';
import '../backend/binding/notification/notification_binding.dart';
import '../backend/binding/profile_binding.dart';
import '../view/book_screen/board_member_details/board_member_details.dart';
import '../view/book_screen/service_member_profile/service_member_profile.dart';
import '../view/home_screen/home_page.dart';
import '../view/loan_screen/loan_edit_screen/loan_edit_screen.dart';
import '../view/loan_screen/loan_page.dart';
import '../view/notification/notification.dart';
import '../view/notification/notificatoin_view/notification_view_screen.dart';
import '../view/notification/poll_details/poll_notification.dart';
import '../view/profile_screen/loan_detailes_screen/activelone_details_screen.dart';
import '../view/profile_screen/profile_loan_screen/profile_loan_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String verifyRoutes = '/verify';
  static const String bottomNavRoutes = '/bottomNav';
  static const String electedMemberRoutes = '/electedMember';
  static const String signUpRoutes = '/signup';
  static const String tabRoutes = '/tabs';
  static const String editProfileRoutes = '/editProfile';
  static const String userProfileRoutes = '/userProfile';
  static const String memberProfileRoutes = '/memberProfile';
  static const String profileRoutes = '/profile';
  static const String searchScreenRoutes = '/search';
  static const String loanEditRoutes = '/loanEdit';
  static const String loanRoutes = '/loan';
  static const String serviceMemberProfileRoutes = '/serviceMemberProfile';
  static const String notificationPageRoutes = '/notificationPage';
  static const String suretyRequestDetailsRoutes = '/suretyRequestDetails';
  static const String loanDetailsRoutes = '/loanDetails';
  static const String notificationPollRoutes = '/notificationPoll';
  static const String profileLoanDetailsRoutes = '/profileLoanDetails';
  static const String boardMemberDetailsRoutes = '/boardMemberDetails';

  static const String splash = '/splash';

  static String getInitialRoute() => initial;
  static String getVerifyRoute() => verifyRoutes;
  static String getSignUpRoute() => signUpRoutes;
  static String getBottomNavRoute() => bottomNavRoutes;
  static String getElectedMemberRoute() => electedMemberRoutes;
  static String getTabRoute() => tabRoutes;
  static String getEditProfileRoute() => editProfileRoutes;
  static String getUserProfileRoute() => userProfileRoutes;
  static String getMemberProfileRoutesRoute() => memberProfileRoutes;
  static String getProfileRoute() => profileRoutes;
  static String getSearchScreenRoute() => searchScreenRoutes;
  static String getLoanEditRoute() => loanEditRoutes;
  static String getLoanRoute() => loanRoutes;
  static String getServiceMemberProfileRoutesRoute() =>
      serviceMemberProfileRoutes;
  static String getNotificationPageRoute() => notificationPageRoutes;
  static String getSuretyRequestDetailsRoute() => suretyRequestDetailsRoutes;
  static String getLoanDetailsRoute() => loanDetailsRoutes;
  static String getNotificationPollRoute() => notificationPollRoutes;
  static String getProfileLoanDetailsRoute() => profileLoanDetailsRoutes;
  static String getBoardMemberDetailsRoutesRoute() => boardMemberDetailsRoutes;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => const LOginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: signUpRoutes,
        page: () => const RegisterScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: bottomNavRoutes,
        page: () => const NavigationBarpage(),
        binding: BottomNavBinding()),
    GetPage(
        name: electedMemberRoutes,
        page: () => const ElectedMemberScreen(),
        binding: ElectedMemberBinding()),
    GetPage(
        name: editProfileRoutes,
        page: () => const ProfileEditScreen(),
        binding: EditProfileBinding()),
    GetPage(
        name: userProfileRoutes,
        page: () => const ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        name: searchScreenRoutes,
        page: () => const SearchScreen(),
        binding: SearchScreenBinding()),
    GetPage(
        name: loanEditRoutes,
        page: () => const LoanEditScreen(),
        binding: LoanEditBinding()),
    GetPage(
        name: loanRoutes,
        page: () => const LoanPage(),
        binding: LoanScreenBinding()),
    GetPage(
        name: serviceMemberProfileRoutes,
        page: () => const ServiceMemberProfile(),
        binding: ServiceMemberDetailsBinding()),
    GetPage(
      name: notificationPageRoutes,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
        name: suretyRequestDetailsRoutes,
        page: () => const NotificationViewScreen(),
        binding: SuretyViewBinding()),
    GetPage(
        name: loanDetailsRoutes,
        page: () => const ProfileLoanScreen(),
        binding: LoanDetailsBinding()),
    GetPage(
      name: notificationPollRoutes,
      page: () => const VoteViewScreen(),
      binding: SuretyViewBinding(),
    ),
    GetPage(
        name: profileLoanDetailsRoutes,
        page: () => const ActiveLoanDetailsScreen(),
        binding: ProfileLoanDataBinding()),
    GetPage(
        name: boardMemberDetailsRoutes,
        page: () => const BoardMemberDetailsScreen(),
        binding: BoardMemberDetailsBinding()),
  ];
}
