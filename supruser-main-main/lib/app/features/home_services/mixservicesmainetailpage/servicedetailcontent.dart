import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_utils.dart';
import '../Serviesdatamodel/servvices_datamodel.dart';
import '../pages/home_cleaning/pages/addonespages.dart';
import '../pages/home_cleaning/provider/home_cleaing_provider.dart';
import '../pages/home_cleaning/widgets/bootombar.dart';
import '../pages/home_cleaning/widgets/customappbar.dart';
import '../pages/home_cleaning/widgets/location_header.dart';
import '../pages/home_cleaning/widgets/progressbar.dart';
import '../widgets/listviewdatastructure.dart';
import '../widgets/tab_banner.dart';

class ServiceDetailsContent extends StatefulWidget {
  final String categoryId;

  const ServiceDetailsContent({
    super.key,
    required this.categoryId,
  });

  @override
  State<ServiceDetailsContent> createState() => _ServiceDetailsContentState();
}

class _ServiceDetailsContentState extends State<ServiceDetailsContent> {
  final ScrollController _tabScrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};

  bool _hasScrolled = false;
  double _scrollOffset = 0.0;
  String? _lastLoadedCategoryId;

  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  @override
  void didUpdateWidget(ServiceDetailsContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      loadCategory();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<BookingProvider>(context, listen: false);
    if (provider.currentCategory == null) {
      loadCategory();
    }
  }

  void loadCategory() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_lastLoadedCategoryId != widget.categoryId) {
        final provider = Provider.of<BookingProvider>(context, listen: false);
        provider.loadCategory(widget.categoryId);
        _lastLoadedCategoryId = widget.categoryId;
      }
    });
  }

  @override
  void dispose() {
    _tabScrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String tab) {
    final key = _sectionKeys[tab];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      _scrollOffset = notification.metrics.pixels;

      if (_scrollOffset > 50 && !_hasScrolled) {
        setState(() => _hasScrolled = true);
      } else if (_scrollOffset <= 50 && _hasScrolled) {
        setState(() => _hasScrolled = false);
      }
    }
    return false;
  }
  void _handleBackNavigation(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context, listen: false);
    provider.resetAll();
    provider.setIsHomeCleaningService(false);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ WRAP WITH WillPopScope
    return WillPopScope(
      onWillPop: () async {
        // Reset provider when mobile back button pressed
        final provider = Provider.of<BookingProvider>(context, listen: false);
        provider.resetAll();
        provider.setIsHomeCleaningService(false);
        print("🔄 Mobile back pressed - Provider reset");
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Consumer<BookingProvider>(
            builder: (context, provider, _) {
              final categoryName = provider.currentCategory?.name ?? "Service Details";
              return CustomAppBar(
                showBackButton: true,
                title: categoryName,
                onBackPressed: () {
                  // ✅ Reset on custom back button too
                  _handleBackNavigation(context);
                },
              );
            },
          ),
        ),
        body: Consumer<BookingProvider>(
          builder: (context, provider, _) {
            if (provider.currentCategory == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final category = provider.currentCategory!;

            for (var tab in category.tabs) {
              _sectionKeys[tab] ??= GlobalKey();
            }

            final isAnyTabSelected = provider.selectedTab != null &&
                provider.selectedTab!.isNotEmpty;
            final shouldShowHorizontal = isAnyTabSelected || _hasScrolled;

            return Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LocationHeaderWidget(provider: provider),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 10)),
                            Text(
                              "Service details",
                              style: TextStyle(
                                fontSize: ResponsiveUtils.sp(context, 24),
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                            const ProgressBarWidget(currentStep: 0),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),
                            Text(
                              "Next step: Popular add-ons",
                              style: TextStyle(
                                fontSize: ResponsiveUtils.sp(context, 12),
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.getSpacing(context, 20),
                        ),
                        child: shouldShowHorizontal
                            ? _buildHorizontalScrollTabs(context, provider, category)
                            : _buildWrappedTabs(context, provider, category),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                      Divider(height: 1, color: AppColors.appGrey.withOpacity(0.3)),
                    ],
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: _handleScrollNotification,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...category.tabs.map((tab) {
                            final tabServices = category.services.where((service) {
                              return service.tabCategory?.toLowerCase() == tab.toLowerCase();
                            }).toList();

                            if (tabServices.isEmpty) return const SizedBox.shrink();

                            final tabBanner = category.tabBanners?[tab];

                            return Column(
                              key: _sectionKeys[tab],
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveUtils.getSpacing(context, 20),
                                  ),
                                  child: Text(
                                    tab,
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.sp(context, 20),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),

                                if (tabBanner != null) ...[
                                  TabBannerWidget(banner: tabBanner),
                                  SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                                ],

                                ...tabServices.map((service) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 0),
                                    child: ServiceCard(service: service),
                                  );
                                }).toList(),

                                SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),
                              ],
                            );
                          }).toList(),

                          SizedBox(height: ResponsiveUtils.getSpacing(context, 200)),
                        ],
                      ),
                    ),
                  ),
                ),
                BottomBarWidget(
                    provider: provider,
                    buttonText: 'Next',
                    onNext: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddOnsPage(
                            categoryId: widget.categoryId,
                          ),
                        ),
                      )
                    }
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWrappedTabs(BuildContext context, BookingProvider provider, dynamic category) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: category.tabs.map<Widget>((tab) {
        final isSelected = provider.selectedTab == tab;
        return GestureDetector(
          onTap: () {
            provider.selectTab(tab);
            Future.delayed(const Duration(milliseconds: 100), () {
              _scrollToSection(tab);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.darkGreen : Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.darkGreen : AppColors.appGrey,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              tab,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHorizontalScrollTabs(BuildContext context, BookingProvider provider, dynamic category) {
    return SingleChildScrollView(
      controller: _tabScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: category.tabs.map<Widget>((tab) {
          final isSelected = provider.selectedTab == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                provider.selectTab(tab);
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollToSection(tab);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.darkGreen : Colors.white,
                  border: Border.all(
                    color: isSelected ? AppColors.darkGreen : AppColors.appGrey,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
class ServiceDetailsContentWithCategory extends StatelessWidget {
  final ServiceCategory category;

  const ServiceDetailsContentWithCategory({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<BookingProvider>(context, listen: false);
      provider.setCategory(category);
    });

    return ServiceDetailsContent(
      categoryId: category.id,
    );
  }
}