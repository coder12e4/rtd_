/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
// import 'package:get/get.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_services_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_slot_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_timing_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/analytics_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/cities_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/firebase_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/individual_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/individual_cities_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/individual_profile_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/packages_specialist_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/product_order_details_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/register_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/salon_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_packages_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/add_stylist_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/app_pages_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/appointment_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/calendar_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/chat_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/contact_us_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/create_products_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/profile_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/gallary_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/history_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/inbox_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/languages_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/login_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/order_details_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/packages_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/products_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/profile_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/review_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/packages_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/services_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/services_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/slot_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/splash_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/stylist_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/shop_categories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/shop_subcategories_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/signup_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/stylist_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/tabs_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/binding/verify_binding.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/add_services.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/add_slot.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/add_timing.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/analytics.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/cities_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/error.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/firebase.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/individual_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/individual_cities.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/individual_profile.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/packages_specialist.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/product_order_details.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/register_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/salon_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/add_packages.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/add_stylist.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/app_pages.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/appointment.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/calendar.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/chat.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/contact_us.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/create_product.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/profile_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/gallary.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/history.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/inbox.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/languages.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/login.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/order_details.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/packages.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/products.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/profile.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/review.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/packages_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/service_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/services.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/slot.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/splash.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/stylist_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/shop_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/shop_subcategories.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/signup.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/stylist.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/tabs.dart';
// import 'package:ultimate_salon_owner_flutter/app/view/verify.dart';

import 'package:get/get.dart';
import 'package:rtd_project/backend/binding/auth/login_binding.dart';
import 'package:rtd_project/backend/binding/auth/register_binding.dart';
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
  static const String reviewRoutes = '/review';
  static const String languagesRoutes = '/languages';
  static const String contactUsRoutes = '/contact_us';
  static const String appPagesRoutes = '/app_pages';
  static const String packagesRoutes = '/packages';
  static const String addPackagesRoutes = '/add_packages';
  static const String packagesCategoriesRoutes = '/select_packages';
  static const String productsRoutes = '/products';
  static const String createProductsRoutes = '/create_products';
  static const String shopCategoriesRoutes = '/shop_categories';
  static const String shopSubCategoriesRoutes = '/shop_subcategories';
  static const String salonCategoriesRoutes = '/salon_categories';
  static const String citiesCategoriesRoutes = '/select_cities';
  static const String slotRoutes = '/slot';
  static const String addSlotRoutes = '/add_slot';
  static const String servicesRoutes = '/services';
  static const String addServicesRoutes = '/add_services';
  static const String servicesCategoriesRoutes = '/services_categories';
  static const String packagesSpecialistRoutes = '/packages_specialist';
  static const String individualProfileRoutes = '/individual_profile';
  static const String individualProfileCategoriesRoutes =
      '/individual_profile_categories';
  static const String individualCitiesRoutes = '/individual_cities';
  static const String errorRoutes = '/error';
  static const String splash = '/splash';
  static const String analyticsRoutes = '/analytics';
  static const String firebaseRoutes = '/firebase_auth';
  static const String productOrderDetailsRoutes = '/product_order_details';
  static const String registerCategoriesRoutes = '/register_categories';

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
  static String getReviewRoute() => reviewRoutes;
  static String getLanguagesRoute() => languagesRoutes;
  static String getContactUsRoute() => contactUsRoutes;
  static String getAppPagesRoute() => appPagesRoutes;
  static String getPackagesRoute() => packagesRoutes;
  static String getAddPackagesRoute() => addPackagesRoutes;
  static String getPackagesCategoriesRoute() => packagesCategoriesRoutes;
  static String getProductsRoute() => productsRoutes;
  static String getCreateProductsRoute() => createProductsRoutes;
  static String getShopCategoriesRoute() => shopCategoriesRoutes;
  static String getShopSubCategoriesRoute() => shopSubCategoriesRoutes;
  static String getSalonCategoriesRoute() => salonCategoriesRoutes;
  static String getCitiesCategoriesRoute() => citiesCategoriesRoutes;
  static String getSlotRoute() => slotRoutes;
  static String getAddSlotRoute() => addSlotRoutes;
  static String getServicesRoute() => servicesRoutes;
  static String getAddServicesRoute() => addServicesRoutes;
  static String getServicesCategoriesRoute() => servicesCategoriesRoutes;
  static String getPackagesSpecialistRoute() => packagesSpecialistRoutes;
  static String getIndividualProfileRoute() => individualProfileRoutes;
  static String getIndividualProfileCategoriesRoute() =>
      individualProfileCategoriesRoutes;
  static String getIndividualCitiesRoute() => individualCitiesRoutes;
  static String getErrorRoutes() => errorRoutes;
  static String getSplashRoutes() => splash;
  static String getAnalyticsRoutes() => analyticsRoutes;
  static String getFirebaseAuthRoutes() => firebaseRoutes;
  static String getProductOrderDetailsRoutes() => productOrderDetailsRoutes;
  static String getRegisterCategoriesRoutes() => registerCategoriesRoutes;

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
        page: () => ElectedMemberScreen(),
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
    // GetPage(
    //     name: reviewRoutes,
    //     page: () => const ReviewScreen(),
    //     binding: ReviewBinding()),
    // GetPage(
    //     name: reviewRoutes,
    //     page: () => const ReviewScreen(),
    //     binding: ReviewBinding()),
    // GetPage(
    //     name: languagesRoutes,
    //     page: () => const LanguagesScreen(),
    //     binding: LanguagesBinding()),
    // GetPage(
    //     name: contactUsRoutes,
    //     page: () => const ContactUsScreen(),
    //     binding: ContactUsBinding()),
    // GetPage(
    //     name: appPagesRoutes,
    //     page: () => const AppPagesScreen(),
    //     binding: AppPagesBinding()),
    // GetPage(
    //     name: packagesRoutes,
    //     page: () => const PackagesScreen(),
    //     binding: PackagesBinding()),
    // GetPage(
    //     name: addPackagesRoutes,
    //     page: () => const AddPackagesScreen(),
    //     binding: AddPackagesBinding()),
    // GetPage(
    //     name: packagesCategoriesRoutes,
    //     page: () => const PackagesCategoriesScreen(),
    //     binding: PackagesCategoriesBinding()),
    // GetPage(
    //     name: productsRoutes,
    //     page: () => const ProductsScreen(),
    //     binding: ProductsBinding()),
    // GetPage(
    //     name: createProductsRoutes,
    //     page: () => const CreateProductsScreen(),
    //     binding: CretaeProductsBinding()),
    // GetPage(
    //     name: shopCategoriesRoutes,
    //     page: () => const ShopCategoriesScreen(),
    //     binding: ShopCategoriesBinding()),
    // GetPage(
    //     name: shopSubCategoriesRoutes,
    //     page: () => const ShopSubCategoriesScreen(),
    //     binding: ShopSubCategoriesBinding()),
    // GetPage(
    //     name: salonCategoriesRoutes,
    //     page: () => const SalonCategoriesScreen(),
    //     binding: SalonCategoriesBinding()),
    // GetPage(
    //     name: citiesCategoriesRoutes,
    //     page: () => const CitiesCategoriesScreen(),
    //     binding: CitiesCategoriesBinding()),
    // GetPage(
    //     name: slotRoutes,
    //     page: () => const SlotScreen(),
    //     binding: SlotBinding()),
    // GetPage(
    //     name: addSlotRoutes,
    //     page: () => const AddSlotScreen(),
    //     binding: AddSlotBinding()),
    // GetPage(
    //     name: addServicesRoutes,
    //     page: () => const AddServicesScreen(),
    //     binding: AddServicesBinding()),
    // GetPage(
    //     name: servicesRoutes,
    //     page: () => const ServicesScreen(),
    //     binding: ServicesBinding()),
    // GetPage(
    //     name: servicesCategoriesRoutes,
    //     page: () => const ServiceCategoriesScreen(),
    //     binding: ServicesCategoriesBinding()),
    // GetPage(
    //     name: packagesSpecialistRoutes,
    //     page: () => const PackagesSpecialistScreen(),
    //     binding: PackagesSpecialistBinding()),
    // GetPage(
    //     name: individualProfileRoutes,
    //     page: () => const IndividualProfileScreen(),
    //     binding: IndividualProfileBinding()),
    // GetPage(
    //     name: individualProfileCategoriesRoutes,
    //     page: () => const IndividualCategoriesScreen(),
    //     binding: IndividualProfileCategoriesBinding()),
    // GetPage(
    //     name: individualCitiesRoutes,
    //     page: () => const IndividualCitiesScreen(),
    //     binding: IndividualCitiesBinding()),
    // GetPage(name: errorRoutes, page: () => const ErrorScreen()),

    // GetPage(
    //     name: analyticsRoutes,
    //     page: () => const AnalyticScreen(),
    //     binding: AnalyticsBinding()),
    // GetPage(
    //     name: firebaseRoutes,
    //     page: () => const FirebaseVerificationScreen(),
    //     binding: FirebaseBinding(),
    //     fullscreenDialog: true),
    // GetPage(
    //     name: productOrderDetailsRoutes,
    //     page: () => const ProductOrderDetailScreen(),
    //     binding: ProductOrderDetailsBinding()),
    // GetPage(
    //     name: registerCategoriesRoutes,
    //     page: () => const RegisterCategoryScreen(),
    //     binding: RegisterCategoriesBinding(),
    //     fullscreenDialog: true)
  ];
}
