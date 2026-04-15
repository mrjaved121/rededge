import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/core/theme/app_theme.dart';
import 'package:suprapp/app/features/auth/provider/auth_provider.dart';
import 'package:suprapp/app/features/auth/provider/name_input_provider.dart';
import 'package:suprapp/app/features/auth/provider/otp_provider.dart';
import 'package:suprapp/app/features/auth/provider/phone_input_provider.dart';
import 'package:suprapp/app/features/bike_ride/provider/bike_provider.dart';
import 'package:suprapp/app/features/dine_out/controller/dine_out_provider.dart';
import 'package:suprapp/app/features/dine_out/controller/filter_color_provider.dart';
import 'package:suprapp/app/features/dine_out/controller/filter_controller.dart';
import 'package:suprapp/app/features/dine_out/controller/offer_controller.dart';
import 'package:suprapp/app/features/dine_out/provider/faqs_provider.dart';
import 'package:suprapp/app/features/dine_out/provider/filter_provider.dart';
import 'package:suprapp/app/features/dine_out/controller/state_controller.dart';
import 'package:suprapp/app/features/dine_out/provider/view_toggler_provider.dart';
import 'package:suprapp/app/features/food/controller/cart_controller.dart';
import 'package:suprapp/app/features/food/controller/food_controller.dart';
import 'package:suprapp/app/features/food/provider/drink_selection_provider.dart';
import 'package:suprapp/app/features/food/provider/food_item_provider.dart';
import 'package:suprapp/app/features/food/provider/selection_toggle_provider.dart';
import 'package:suprapp/app/features/groceries/controllers/address_provider.dart';
import 'package:suprapp/app/features/groceries/controllers/herbal_provider.dart';
import 'package:suprapp/app/features/groceries/controllers/product_quantity_provider.dart';
import 'package:suprapp/app/features/groceries/controllers/tab_provider.dart';
import 'package:suprapp/app/features/home/provider/image_carousel_provider.dart';
import 'package:suprapp/app/features/profile/controller/bank_controller.dart';
import 'package:suprapp/app/features/profile/controller/date_provider.dart';
import 'package:suprapp/app/features/profile/controller/gender_controller.dart';
import 'package:suprapp/app/features/profile/controller/language_controller.dart';
import 'package:suprapp/app/features/profile/controller/profile_controller.dart';
import 'package:suprapp/app/features/rides/provider/bottom_sheet_provider.dart';
import 'package:suprapp/app/features/rides/provider/cancel_provider.dart';
import 'package:suprapp/app/features/rides/provider/date_provider.dart';
import 'package:suprapp/app/features/rides/provider/favorite_provider.dart';
import 'package:suprapp/app/features/rides/provider/map_provider.dart';
import 'package:suprapp/app/features/rides/provider/pick_up_provider.dart';
import 'package:suprapp/app/features/rides/provider/saved_favorit_location.dart';
import 'package:suprapp/app/features/rides/provider/selecting_car_provider.dart';
import 'package:suprapp/app/features/rides/provider/selection_provider.dart';
import 'package:suprapp/app/routes/go_router.dart';

import '../features/home_services/pages/home_cleaning/provider/home_cleaing_provider.dart';
import '../features/rides/controller/ride_controller.dart';
import '../features/supr_pay/provider/supr_pay_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhoneInputProvider()),
        ChangeNotifierProvider(create: (_) => OTPProvider()..startTimer()),
        ChangeNotifierProvider<ProfileController>(
            create: (_) => ProfileController()),
        ChangeNotifierProvider<LanguageController>(
            create: (_) => LanguageController()),
        ChangeNotifierProvider<BankProvider>(create: (_) => BankProvider()),
        ChangeNotifierProvider<GenderProvider>(create: (_) => GenderProvider()),
        ChangeNotifierProvider<DateProvider>(create: (_) => DateProvider()),
        ChangeNotifierProvider<DineOutProvider>(
            create: (_) => DineOutProvider()),
        ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => FAQProvider()),
        ChangeNotifierProvider(create: (_) => FilterProviders()),
        ChangeNotifierProvider(create: (_) => DineOutProvider()),
        ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
        ChangeNotifierProvider<AppBarProvider>(create: (_) => AppBarProvider()),
        ChangeNotifierProvider(create: (_) => ViewToggleProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => QuantityProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider<OfferProvider>(create: (_) => OfferProvider()),
        ChangeNotifierProvider<FoodController>(
          create: (_) => FoodController(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodToggleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PickupDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SelectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MapProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomSheetProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PickupTimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DrinkSelectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CancelReasonProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SavedLocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryFilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NameInputProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProviders(),
        ),
        ChangeNotifierProvider(
          create: (_) => BikeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => RideController()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(
          create: (_) => SuprPayProvider(),
        ),
      ],
      child: GlobalLoaderOverlay(
        child: MaterialApp.router(
          title: 'Supr App',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,
          theme: AppTheme.instance.lightTheme,
          routerDelegate: MyAppRouter.router.routerDelegate,
          routeInformationParser: MyAppRouter.router.routeInformationParser,
          routeInformationProvider: MyAppRouter.router.routeInformationProvider,
        ),
      ),
    );
  }
}
