/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
// import 'package:get/get.dart';
// import 'package:rtd_project/helper/shared_pref.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/api/api.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_services_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_slot_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_timing_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/analytics_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/cities_categories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/firebase_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/individual_categories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/individual_cities_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/individual_profile_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/packages_specialist_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/product_order_details_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/register_categories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/salon_categories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_packages_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/add_stylist_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/app_pages_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/appointment_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/calendar_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/chat_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/contact_us_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/create_products_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/profile_categories_parser.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/gallary_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/history_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/inbox_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/languages_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/login_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/order_details_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/packages_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/products_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/profile_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/review_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/packages_categories.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/service_categories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/services_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/slot_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/splash_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/stylist_categories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/shop_categories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/shop_subcategories_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/signup_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/stylist_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/tabs_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/backend/parse/verify_parse.dart';
// import 'package:ultimate_salon_owner_flutter/app/controller/analytics_controller.dart';
// import 'package:ultimate_salon_owner_flutter/app/controller/appointment_controller.dart';
// import 'package:ultimate_salon_owner_flutter/app/controller/calendar_controller.dart';
// import 'package:ultimate_salon_owner_flutter/app/controller/history_controller.dart';
// import 'package:ultimate_salon_owner_flutter/app/controller/profile_controller.dart';
// import 'package:ultimate_salon_owner_flutter/app/controller/tabs_controller.dart';
// import 'package:ultimate_salon_owner_flutter/app/env.dart';
// import 'package:ultimate_salon_owner_flutter/app/helper/shared_pref.dart';

import 'package:get/get.dart';
import 'package:rtd_project/backend/api/api.dart';
import 'package:rtd_project/backend/parser/authentication/login_parser.dart';
import 'package:rtd_project/backend/parser/authentication/sighnup_parser.dart';
import 'package:rtd_project/backend/parser/book/service_member_parser.dart';
import 'package:rtd_project/backend/parser/elected_member_parser.dart';
import 'package:rtd_project/backend/parser/home_parser.dart';
import 'package:rtd_project/backend/parser/loan/loan_edit_parser.dart';
import 'package:rtd_project/backend/parser/notification/notification_parser.dart';
import 'package:rtd_project/backend/parser/profile/profile_parser.dart';
import 'package:rtd_project/backend/parser/search_parser.dart';
import 'package:rtd_project/core/constraints/api_urls.dart';
import 'package:rtd_project/helper/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/parser/book/books_parser.dart';
import '../backend/parser/bottom_navigation_parser.dart';
import '../backend/parser/loan/loan_screen_parser.dart';
import '../backend/parser/profile/edit_profile_parser.dart';
import '../backend/parser/splash_screen_parser.dart';
import '../backend/parser/wall_screen_parser.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref),
      permanent: true,
    );

    Get.lazyPut(() => ApiService(appBaseUrl: Constants.baseUrl));

    // // Parser LazyLoad

    Get.lazyPut(
        () => LoginParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
      () => ElectedMemberParser(
          apiService: Get.find(), sharedPreferencesManager: Get.find()),
    );
    Get.lazyPut(
        () => SignUpParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => HomeParser(
            sharedPreferencesManager: Get.find(), apiService: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => EditProfileParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ProfileParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => BookScreenParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => LoanScreenParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => WallScreenParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => BottomNavParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => LoanEditParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => SearchScreenParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => ServiceMemberDetailsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    Get.lazyPut(
        () => NotificationParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    //   Get.lazyPut(
    //       () => StylistParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => AddStylistParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => StylistCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ProfileCategoriesParse(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => GallaryParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ReviewParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => LanguagesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ContactUsParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => AppPagesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => PackagesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => AddPackagesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => PackagesCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ProductsParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => CreateProductsParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ShopCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ShopSubCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => SalonCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => CitiesCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => AddTimingParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => SlotParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => AddSlotParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => AddServicesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ServicesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ServicesCategorisParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => PackagesSpecialistParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => IndividualProfileParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => IndividualProfileCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => IndividualCitiesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    Get.lazyPut(() => SplashScreenParser(sharedPreferencesManager: Get.find()),
        fenix: true);

    //   Get.lazyPut(
    //       () => AnalyticsParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => FirebaseParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => ProductOrderDetailsParse(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(
    //       () => RegisterCategoriesParser(
    //           apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //       fenix: true);

    //   Get.lazyPut(() => TabsController(parser: Get.find()));
    //   Get.lazyPut(() => AppointmentController(parser: Get.find()));
    //   Get.lazyPut(() => HistoryController(parser: Get.find()));
    //   Get.lazyPut(() => AnalyticsController(parser: Get.find()));
    //   Get.lazyPut(() => CalendarsController(parser: Get.find()));
    //   Get.lazyPut(() => ProfileController(parser: Get.find()));
  }
}
