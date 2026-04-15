import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/features/auth/pages/enter_name.dart';
import 'package:suprapp/app/features/bike_ride/pages/bike_ride_page.dart';
import 'package:suprapp/app/features/dine_out/pages/another_restorant.dart';
import 'package:suprapp/app/features/dine_out/pages/cream_plus.dart';
import 'package:suprapp/app/features/dine_out/pages/detail_dine_out.dart';
import 'package:suprapp/app/features/dine_out/pages/dine_out_page.dart';
import 'package:suprapp/app/features/dine_out/pages/menu_page.dart';
import 'package:suprapp/app/features/dine_out/pages/favourite_restaurent_page.dart';
import 'package:suprapp/app/features/dine_out/pages/faqs_page.dart';
import 'package:suprapp/app/features/dine_out/pages/filter_widget.dart';
import 'package:suprapp/app/features/dine_out/pages/restaurent_photos.dart';
import 'package:suprapp/app/features/dine_out/pages/terms_condition.dart';
import 'package:suprapp/app/features/dine_out/pages/offer_page.dart';
import 'package:suprapp/app/features/dine_out/pages/usefull_bit.dart';
import 'package:suprapp/app/features/food/pages/food_page.dart';
import 'package:suprapp/app/features/food/pages/food_detail_page.dart';
import 'package:suprapp/app/features/food/pages/food_home_page.dart';
import 'package:suprapp/app/features/food/pages/offers_tabs_page.dart';
import 'package:suprapp/app/features/food/pages/order_confirmation_page.dart';
import 'package:suprapp/app/features/groceries/groceries_home_screen.dart';
import 'package:suprapp/app/features/groceries/tabs/detail_product_screen.dart';
import 'package:suprapp/app/features/home/widgets/activities_page.dart';
import 'package:suprapp/app/features/home/widgets/help_center_page.dart';
import 'package:suprapp/app/features/home/widgets/ride_detail_page.dart';
import 'package:suprapp/app/features/profile/pages/account_setting_screen.dart';
import 'package:suprapp/app/features/profile/pages/add_bank_screen.dart';
import 'package:suprapp/app/features/profile/pages/bank_screen.dart';
import 'package:suprapp/app/features/profile/pages/contact_screen.dart';
import 'package:suprapp/app/features/profile/pages/delete_account_screen.dart';
import 'package:suprapp/app/features/profile/pages/help_center_screen.dart';
import 'package:suprapp/app/features/profile/pages/invite_screen.dart';
import 'package:suprapp/app/features/profile/pages/language_screen.dart';
import 'package:suprapp/app/features/profile/pages/manage_business_profile.dart';
import 'package:suprapp/app/features/profile/pages/notification_screen.dart';
import 'package:suprapp/app/features/profile/pages/personal_info.dart';
import 'package:suprapp/app/features/profile/pages/profile.dart';
import 'package:suprapp/app/features/profile/pages/saved_address_page.dart';
import 'package:suprapp/app/features/profile/pages/select_country_screen.dart';
import 'package:suprapp/app/features/profile/pages/settings_screen.dart';
import 'package:suprapp/app/features/profile/pages/update_email.dart';
import 'package:suprapp/app/features/profile/pages/update_name.dart';
import 'package:suprapp/app/features/profile/pages/update_phone_no.dart';
import 'package:suprapp/app/features/profile/pages/contact_us_page.dart';
import 'package:suprapp/app/features/rides/pages/activity_page.dart';
import 'package:suprapp/app/features/rides/pages/detail_cancel.dart';
import 'package:suprapp/app/features/rides/pages/enter_pick_up_location.dart';
import 'package:suprapp/app/features/rides/pages/manage_ride_page.dart';
import 'package:suprapp/app/features/rides/pages/ride_home_page.dart';
import 'package:suprapp/app/features/rides/pages/save_location_page.dart';
import 'package:suprapp/app/features/rides/pages/search_city_page.dart';
import 'package:suprapp/app/features/rides/pages/search_page.dart';
import 'package:suprapp/app/features/rides/pages/your_ride.dart';
import 'package:suprapp/app/features/rides/widgets/find_captain_sheet.dart';
import 'package:suprapp/app/features/shops/pages/shops_screen.dart';
import 'package:suprapp/app/features/supr_pay/pages/supr_pay.dart';
import 'package:suprapp/app/routes/error_route.dart';
import 'package:suprapp/app/routes/route_transition.dart';
import 'package:suprapp/app/features/auth/pages/biometric_setup_page.dart';
import 'package:suprapp/app/features/auth/pages/phone_auth_page.dart';
import 'package:suprapp/app/features/auth/pages/verify_phone_auth_page.dart';
import 'package:suprapp/app/features/home/home.dart';
import 'package:suprapp/app/get_started/pages/splash_screen.dart';

import '../features/home_services/model/service_model.dart';

import '../features/home_services/pages/ac_cleaning/ac_cleaning_page.dart';
import '../features/home_services/pages/deep_cleaning/deep_cleaning_page.dart';
import '../features/home_services/pages/furniture_cleaning/furniture_cleaning_page.dart';
import '../features/home_services/pages/home_cleaning/home_cleaning_page.dart';
import '../features/home_services/pages/home_cleaning/pages/addonespages.dart';
import '../features/home_services/pages/home_cleaning/pages/checkoutpages.dart';
import '../features/home_services/pages/home_cleaning/pages/dataandtime.dart';
import '../features/home_services/pages/homepage.dart';
import '../features/home_services/pages/iv_therapy/iv_therapy_page.dart';
import '../features/home_services/pages/labs_tests/lab_tests_page.dart';
import '../features/home_services/pages/laundry_service/laundry_home_page.dart';
import '../features/home_services/pages/packers_movers/packers_movers_page.dart';
import '../features/home_services/pages/pest_control/pest_control_page.dart';
import '../features/home_services/pages/salon_spa/salon_spa_page.dart';
import '../features/home_services/splashscreen.dart';
import '../features/payment_option/pages/payment_options_screen.dart';
import '../features/payment_option/widgets/add_card_screen.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.splashScreen}',
    routes: [
      GoRoute(
        name: AppRoute.splashScreen,
        path: '/${AppRoute.splashScreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.phoneAuthPage,
        path: '/${AppRoute.phoneAuthPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const PhoneAuthPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.verifyPhoneAuthPage,
        path: '/${AppRoute.verifyPhoneAuthPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const VerifyPhoneAuthPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.bioMetricSetupPage,
        path: '/${AppRoute.bioMetricSetupPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const BiometricSetupPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.homePage,
        path: '/${AppRoute.homePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
          name: AppRoute.profilePage,
          path: '/${AppRoute.profilePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ProfileScreen(),
              )),
      GoRoute(
        name: AppRoute.contactUsPage,
        path: '/${AppRoute.contactUsPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ContactUsPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.helpCenterPage,
        path: '/${AppRoute.helpCenterPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const HelpCenterPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.winRewardPage,
        path: '/${AppRoute.winRewardPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const WinRewardScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.notificationpage,
        path: '/${AppRoute.notificationpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const NotificationSettingsScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.invitePage,
        path: '/${AppRoute.invitePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const InviteFriendsScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.settingPage,
        path: '/${AppRoute.settingPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ProfileSettingsScreen(),
        ),
      ),

      GoRoute(
        name: AppRoute.contactpage,
        path: '/${AppRoute.contactpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ContactUsScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.languagePage,
        path: '/${AppRoute.languagePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const LanguageScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.deleteAccountPage,
        path: '/${AppRoute.deleteAccountPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const DeleteAccountScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.bankpage,
        path: '/${AppRoute.bankpage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const BankAccountScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.addBankPage,
        path: '/${AppRoute.addBankPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const AddBankAccountScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.accountSettingPage,
        path: '/${AppRoute.accountSettingPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const AccountSettingsScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.selectcCountryPage,
        path: '/${AppRoute.selectcCountryPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SelectCountryScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.personalInfo,
        path: '/${AppRoute.personalInfo}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const PersonalInfo(),
        ),
      ),
      GoRoute(
        name: AppRoute.updateNamePage,
        path: '/${AppRoute.updateNamePage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const UpdateName(),
        ),
      ),
      GoRoute(
        name: AppRoute.updateemailPage,
        path: '/${AppRoute.updateemailPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const UpdateEmai(),
        ),
      ),
      GoRoute(
        name: AppRoute.updatePhonPage,
        path: '/${AppRoute.updatePhonPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const UpdatePhoneNo(),
        ),
      ),
      GoRoute(
        name: AppRoute.dineOutPage,
        path: '/${AppRoute.dineOutPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const DineOutPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.favouriteRestaurentPage,
        path: '/${AppRoute.favouriteRestaurentPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const FavouriteRestaurentPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.detailDineOutPage,
        path: '/${AppRoute.detailDineOutPage}/:parentIndex',
        pageBuilder: (context, state) {
          final parentIndex = int.parse(state.pathParameters['parentIndex']!);
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: DetailDineOut(parentIndex: parentIndex),
          );
        },
      ),
      GoRoute(
        name: AppRoute.anotherpage,
        path: '/${AppRoute.anotherpage}/:parentIndex/:childIndex',
        builder: (context, state) {
          final parentIndex = int.parse(state.pathParameters['parentIndex']!);
          final childIndex = int.parse(state.pathParameters['childIndex']!);
          return AnotherRestorantScreen(
            parentIndex: parentIndex,
            childIndex: childIndex,
          );
        },
      ),
      GoRoute(
        name: AppRoute.faqsPage,
        path: '/${AppRoute.faqsPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const FaqsPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.termsConditionPage,
        path: '/${AppRoute.termsConditionPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const TermsConditionPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.filterPage,
        path: '/${AppRoute.filterPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const FilterWidget(),
        ),
      ),
      GoRoute(
        name: AppRoute.menu,
        path: '/${AppRoute.menu}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const MenuScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.restaurentPhotosPage,
        path: '/${AppRoute.restaurentPhotosPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const RestaurentPhotosPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.usefull,
        path: '/${AppRoute.usefull}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const FiliCafeDetails(),
        ),
      ),
      GoRoute(
          name: AppRoute.creamplusPage,
          path: '/${AppRoute.creamplusPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const CareemPlusScreen(),
              )),
      GoRoute(
          name: AppRoute.offer,
          path: '/${AppRoute.offer}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const OfferScreen(),
              )),
      GoRoute(
        name: AppRoute.foodPage,
        path: '/${AppRoute.foodPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const FoodPage(),
        ),
      ),
      GoRoute(
          name: AppRoute.foodHomePage,
          path: '/${AppRoute.foodHomePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const FoodHomePage(),
              )),
      GoRoute(
          name: AppRoute.foodDetail,
          path: '/${AppRoute.foodDetail}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const FoodDetailPage(),
              )),
      GoRoute(
          name: AppRoute.enterPickUpLocationPage,
          path: '/${AppRoute.enterPickUpLocationPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const EnterPickUpLocationPage(),
              )),
      GoRoute(
        name: AppRoute.searchLocationPage,
        path: '/${AppRoute.searchLocationPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SearchPage(),
        ),
      ),
      //!---- Grocery Section---- !//
      GoRoute(
          name: AppRoute.groceryHomeScreen,
          path: '/${AppRoute.groceryHomeScreen}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: GroceriesHomeScreen(),
              )),
      GoRoute(
          name: AppRoute.savedLocationPage,
          path: '/${AppRoute.savedLocationPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: SaveLocationPage(),
              )),
      GoRoute(
          name: AppRoute.searchCityPage,
          path: '/${AppRoute.searchCityPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: SearchCityPage(),
              )),
      GoRoute(
          name: AppRoute.rideHome,
          path: '/${AppRoute.rideHome}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const RideHomePage(),
              )),
      GoRoute(
        name: AppRoute.orderConfirmationPage,
        path: '/${AppRoute.orderConfirmationPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const OrderConfirmationPage(),
        ),
      ),
      GoRoute(
          name: AppRoute.manageRide,
          path: '/${AppRoute.manageRide}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ManageRidePage(),
              )),
      GoRoute(
          name: AppRoute.yourRidePage,
          path: '/${AppRoute.yourRidePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const YourRideScreen(),
              )),
      GoRoute(
          name: AppRoute.activity,
          path: '/${AppRoute.activity}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ActivitiesScreen(),
              )),
      GoRoute(
          name: AppRoute.detailcancelRidePage,
          path: '/${AppRoute.detailcancelRidePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const DetailCancelRide(),
              )),
      GoRoute(
          name: AppRoute.offersTabPage,
          path: '/${AppRoute.offersTabPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const OffersTabsPage(),
              )),
      GoRoute(
          name: AppRoute.detailproduct,
          path: '/${AppRoute.detailproduct}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ProductDetailScreen(),
              )),
      GoRoute(
          name: AppRoute.enterNamePage,
          path: '/${AppRoute.enterNamePage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const EnterNamePage(),
              )),
      GoRoute(
          name: AppRoute.suprPayPage,
          path: '/${AppRoute.suprPayPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const SuprWalletPage(),
              )),
      GoRoute(
          name: AppRoute.savedAddressPage,
          path: '/${AppRoute.savedAddressPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const SavedAddressPage(),
              )),
      GoRoute(
          name: AppRoute.manageBusinessProfile,
          path: '/${AppRoute.manageBusinessProfile}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ManageBusinessProfilePage(),
              )),

      GoRoute(
          name: AppRoute.bikeRideHome,
          path: '/${AppRoute.bikeRideHome}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const BikeRidePage(),
              )),
      GoRoute(
          name: AppRoute.shopScreen,
          path: '/${AppRoute.shopScreen}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ShopsScreen(),
              )),
      GoRoute(
          name: AppRoute.findingCaptain,
          path: '/${AppRoute.findingCaptain}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const FindCaptainBottomSheet(),
              )),
      GoRoute(
          name: AppRoute.activitiesPage,
          path: '/${AppRoute.activitiesPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const ActivitiesPage(),
              )),
      GoRoute(
          name: AppRoute.rideDetailPage,
          path: '/${AppRoute.rideDetailPage}',
          pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
                context: context,
                state: state,
                child: const RideDetailPage(),
              )),
      GoRoute(
        path: '/payment-options',
        name: AppRoute.paymentOptions,
        builder: (context, state) => const PaymentOptionsScreen(),
      ),
      GoRoute(
        path: '/add-card',
        name: AppRoute.addCard,
        builder: (context, state) => const AddCardScreen(),
      ),
      GoRoute(
        path: '/home-services',
        builder: (context, state) => const HomeServicesPage(),
      ),
      GoRoute(
        path: '/home-cleaning',
        builder: (context, state) => const HomeCleaningPage(),
      ),
      GoRoute(
        path: '/laundry-service',
        builder: (context, state) => const LaundryHomePage(),
      ),
      GoRoute(
        path: '/salon-spa',
        builder: (context, state) => const SalonSpaPage(),
      ),
      GoRoute(
        path: '/furniture-cleaning',
        builder: (context, state) => const FurnitureCleaningPage(),
      ),
      GoRoute(
        path: '/ac-cleaning',
        builder: (context, state) => const AcCleaningPage(),
      ),
      GoRoute(
        path: '/iv-therapy',
        builder: (context, state) => const IvTherapyPage(),
      ),
      GoRoute(
        path: '/lab-tests',
        builder: (context, state) => const LabTestsPage(),
      ),
      GoRoute(
        path: '/deep-cleaning',
        builder: (context, state) => const DeepCleaningPage(),
      ),
      GoRoute(
        path: '/pest-control',
        builder: (context, state) => const PestControlPage(),
      ),
      GoRoute(
        path: '/packers-movers',
        builder: (context, state) => const PackersMoversPage(),
      ),
      // GoRoute(
      //   path: '/home-cleaning-splash',
      //   name: 'home-cleaning-splash',
      //   builder: (context, state) => const (),
      // ),
      GoRoute(
        path: '/home-cleaning-service-details',
        name: 'home-cleaning-service-details',
        builder: (context, state) => const HomeCleaningPage(),
      ),
      GoRoute(
        path: '/home-cleaning-add-ons',
        name: 'home-cleaning-add-ons',
        builder: (context, state) => const AddOnsPage(),
      ),
      GoRoute(
        path: '/home-cleaning-date-time',
        name: 'home-cleaning-date-time',
        builder: (context, state) => const DateTimePage(),
      ),
      GoRoute(
        path: '/home-cleaning-checkout',
        name: 'home-cleaning-checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
  static const String errorPage = 'error-page';
  //!---- Profile Section---- !//
  static const String profilePage = 'profile'; //
  static const String contactUsPage = 'contact-us-page';
  static const String winRewardPage = 'help-center-screen';
  static const String notificationpage = 'notification-screen';
  static const String invitePage = 'invite-screen';
  static const String settingPage = 'settings-screen';
  static const String changePasswordPage = 'change-passorsd-screen';
  static const String contactpage = 'contact-screen';
  static const String languagePage = 'language-screen';
  static const String deleteAccountPage = 'delete-account-screen';
  static const String bankpage = 'bank-screen';
  static const String addBankPage = 'add-bank-screen';
  static const String accountSettingPage = 'account-setting-screen';
  static const String selectcCountryPage = 'select-country-screen';
  static const String personalInfo = 'personal-info';
  static const String updateNamePage = 'update-name';
  static const String updateemailPage = 'update-email';
  static const String updatePhonPage = 'update-phone-no';
  static const String splashScreen = 'splash-page';
  static const String homePage = 'home-page';
  static const String savedAddressPage = 'saved-address-page';
  static const String manageBusinessProfile = 'manage-business-profile';
  static const String helpCenterPage = 'help-center-page';
  static const String activitiesPage = 'activities-page';
  static const String rideDetailPage = 'ride-detail-page';
  //!---- Auth Section---- !//
  static const String phoneAuthPage = 'phone-auth-page';
  static const String verifyPhoneAuthPage = 'verify-phone-auth-page';
  static const String bioMetricSetupPage = 'bio-metric-page';
  static const String enterNamePage = 'enter-name-page';
//!---- DineOut Section---- !//
  static const String dineOutPage = 'dine-out-page';
  static const String favouriteRestaurentPage = 'favourite-restaurent-page';
  static const String detailDineOutPage = 'detail-dine-out';
  static const String anotherpage = 'another-retorant';
  static const String usefull = 'usefull-bit';
  static const String filterPage = 'filter-page';
  static const String termsConditionPage = 'terms-condition-page';
  static const String faqsPage = 'faqs-page';
  static const String menu = 'menu-page';
  static const String creamplusPage = 'cream-plus';
  static const String restaurentPhotosPage = 'restaurent-photos-page';
  static const String offer = 'offer-page';
  //!---- Food Section---- !//
  static const String foodPage = 'food-page';
  static const String foodHomePage = 'food-home-page';
  static const String foodDetail = 'food-detail-page';
  static const String orderConfirmationPage = 'order-confirmation-page';
  static const String offersTabPage = 'offers-tabs-page';
  //!---- Rides Section---- !//
  static const String enterPickUpLocationPage = 'enter-pick-up-location-page';
  static const String rideHome = 'ride-home-page';
  static const String searchLocationPage = 'search-location-page';
  static const String savedLocationPage = 'saved-location-page';
  static const String searchCityPage = 'search-city-page';
  static const String manageRide = 'manage-ride-page';
  static const String yourRidePage = 'your-ride';
  static const String activity = 'activity-page';
  static const String findingCaptain = 'finding-captain-sheet';
  static const String detailcancelRidePage = 'detail-cancel';
  //!---- Grocery Section---- !//
  static const String groceryHomeScreen = 'grocery-home-screen';
  static const String detailproduct = 'detail-product-screen';

  //!---- Supr pay Section---- !//
  static const String suprPayPage = 'supr-pay-page';

  //!---- Bike Rides ---- !//
  static const String bikeRideHome = 'bike-ride-home-page';
  //!----Shops ---- !//
  static const String shopScreen = 'shops-screen';

//   this for payment option
  static const String paymentOptions = 'paymentOptions';
  static const String addCard = 'addCard';
}
