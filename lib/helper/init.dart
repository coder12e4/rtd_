
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
import '../backend/parser/loan/loan_details_parser.dart';
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

    Get.lazyPut(() => SplashScreenParser(sharedPreferencesManager: Get.find()),
        fenix: true);

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

    Get.lazyPut(
        () => LoanDetailsParser(
            apiService: Get.find(), sharedPreferencesManager: Get.find()),
        fenix: true);

    // Get.lazyPut(
    //     () => StylistCategoriesParser(
    //         apiService: Get.find(), sharedPreferencesManager: Get.find()),
    //     fenix: true);

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
  }
}
