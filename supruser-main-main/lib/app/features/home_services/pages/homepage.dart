import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/global_variables.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../shared/widgets/custom_menu_button.dart';
import '../../home/widgets/top_sheet.dart';
import '../provider/home_services_provider.dart';
import '../provider/service_navigation_helper.dart';
import '../widgets/main_service_card.dart';
import '../widgets/service_grid_item.dart';
import '../widgets/offer_card.dart';
import 'home_cleaning/provider/home_cleaing_provider.dart';


class HomeServicesPage extends StatefulWidget {
  const HomeServicesPage({Key? key}) : super(key: key);

  @override
  State<HomeServicesPage> createState() => _HomeServicesPageState();
}

class _HomeServicesPageState extends State<HomeServicesPage> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<BookingProvider>();


      provider.resetAll();


      provider.setIsHomeCleaningService(false);
    });
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeServicesProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: Consumer<HomeServicesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),

                    // Main Services
                    _buildMainServices(context, provider),

                    SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

                    // All Services Grid
                    _buildAllServices(context, provider),

                    SizedBox(height: ResponsiveUtils.getSpacing(context, 60)),

                    // Top Offers Section
                    _buildTopOffers(context, provider),

                    SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => context.pop(),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.appGrey),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.darkGrey,
              size: 20,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        "Home Services",
        style: textTheme(context).bodyLarge?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: ResponsiveUtils.sp(context, 20),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomMenuButton(
            onPressed: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: 'TopSheet',
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                transitionBuilder: (_, animation, __, ___) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: TopSheetWidget(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMainServices(BuildContext context, HomeServicesProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 16),
      ),
      child: Row(
        children: [
          for (int i = 0; i < provider.mainServices.length; i++) ...[
            Expanded(
              child: MainServiceCard(
                service: provider.mainServices[i],
                onTap: () {
                  // ✅ UPDATED: Navigate with splash screen
                  ServiceNavigationHelper.navigateToService(
                    context,
                    provider.mainServices[i],
                  );
                },
              ),
            ),
            if (i < provider.mainServices.length - 1)
              SizedBox(width: ResponsiveUtils.getSpacing(context, 16)),
          ],
        ],
      ),
    );
  }

  Widget _buildAllServices(BuildContext context, HomeServicesProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 16),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: ResponsiveUtils.getSpacing(context, 12),
          crossAxisSpacing: ResponsiveUtils.getSpacing(context, 12),
          childAspectRatio: ResponsiveUtils.adaptive(context,
              small: 0.85, medium: 0.9, large: 0.95),
        ),
        itemCount: provider.allServices.length,
        itemBuilder: (context, index) {
          return ServiceGridItem(
            service: provider.allServices[index],
            onTap: () {
              ServiceNavigationHelper.navigateToService(
                context,
                provider.allServices[index],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTopOffers(BuildContext context, HomeServicesProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getSpacing(context, 16),
          ),
          child: Text(
            'Top Offers',
            style: textTheme(context).headlineSmall?.copyWith(
              fontSize: ResponsiveUtils.sp(context, 22),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

        SizedBox(
          height: ResponsiveUtils.adaptive(context,
              small: 180, medium: 200, large: 220, tablet: 240),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.getSpacing(context, 16),
            ),
            itemCount: provider.topOffers.length,
            separatorBuilder: (context, index) => SizedBox(
              width: ResponsiveUtils.getSpacing(context, 16),
            ),
            itemBuilder: (context, index) {
              return OfferCard(
                offer: provider.topOffers[index],
                onTap: () {
                  //  UPDATED: Find service and navigate with splash
                  final offerTitle = provider.topOffers[index].title.toLowerCase();

                  // Find matching service from all services
                  final matchingService = _findServiceByOfferTitle(
                    provider,
                    offerTitle,
                  );

                  if (matchingService != null) {
                    ServiceNavigationHelper.navigateToService(
                      context,
                      matchingService,
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper function to find service by offer title
  dynamic _findServiceByOfferTitle(HomeServicesProvider provider, String offerTitle) {
    // Check main services first
    for (var service in provider.mainServices) {
      if (service.title.toLowerCase().contains(offerTitle) ||
          offerTitle.contains(service.title.toLowerCase())) {
        return service;
      }
    }

    // Check all services
    for (var service in provider.allServices) {
      final cleanTitle = service.title.toLowerCase().replaceAll('\n', ' ');
      if (cleanTitle.contains(offerTitle) ||
          offerTitle.contains(cleanTitle)) {
        return service;
      }
    }

    // Default to home cleaning if no match
    return provider.mainServices.isNotEmpty ? provider.mainServices[0] : null;
  }
}