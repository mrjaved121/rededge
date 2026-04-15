import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/home/widgets/ride_tile.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 10, vsync: this);
    super.initState();
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(
              text,
              style: textTheme(context)
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward, size: 16),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          ),
          const Divider(
            color: AppColors.appGrey,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.appGrey),
                            borderRadius: BorderRadius.circular(7)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.darkGrey,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Activities",
                      style: textTheme(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
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
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: colorScheme(context).primary,
                            border: Border.all(color: AppColors.appGrey),
                            borderRadius: BorderRadius.circular(7)),
                        child: const Icon(
                          Icons.menu,
                          color: Color.fromARGB(255, 20, 188, 96),
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Custom TabBar
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                padding: EdgeInsets.zero,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                labelColor: Colors.black,
                unselectedLabelColor: AppColors.darkGrey.withOpacity(0.5),
                dividerColor: AppColors.appGrey,
                tabs: [
                  Tab(
                    icon: Icon(Icons.grid_view),
                    child: Text(
                      "All",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.directions_car),
                    child: Text(
                      "Rides",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.account_balance_wallet),
                    child: Text(
                      "Pay",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.food_bank),
                    child: Text(
                      "Food",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.local_grocery_store),
                    child: Text(
                      "Groceries",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.dinner_dining_outlined),
                    child: Text(
                      "Dineout",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.bike_scooter),
                    child: Text(
                      "Bike",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.delivery_dining),
                    child: Text(
                      "Delievery",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.home),
                    child: Text(
                      "Home Services",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.car_rental),
                    child: Text(
                      "Car Rental",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

              // Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // All Tab
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tuesday 10, June",
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RideTile(
                            imagePath: AppImages.rides,
                            title: 'Ride to Dubai Mall',
                            time: 'Today 11:49 am',
                            fare: 'INR 200',
                            status: 'Cancelled',
                            statusColor: Theme.of(context).colorScheme.error,
                            onTap: () {
                              context.pushNamed(AppRoute.rideDetailPage);
                            },
                            onStatusTap: () {
                              // Handle status click
                            },
                          ),
                          RideTile(
                            imagePath: AppImages.rides,
                            title: 'Ride to Mona',
                            time: 'Today 11:31 am',
                            fare: 'INR 200',
                            status: 'Cancelled',
                            statusColor: Theme.of(context).colorScheme.error,
                            onTap: () {
                              context.pushNamed(AppRoute.rideDetailPage);
                            },
                            onStatusTap: () {
                              // Handle status click
                            },
                          ),
                          Text(
                            "Tuesday 20, July",
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RideTile(
                            imagePath: AppImages.rides,
                            title: 'Executive Ride',
                            time: 'Today 11:49 am',
                            fare: 'INR 200',
                            status: 'Cancelled',
                            statusColor: Theme.of(context).colorScheme.error,
                            onTap: () {
                              context.pushNamed(AppRoute.rideDetailPage);
                            },
                            onStatusTap: () {
                              // Handle status click
                            },
                          ),
                        ],
                      ),
                    ),

                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tuesday 10, June",
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RideTile(
                            imagePath: AppImages.rides,
                            title: 'Ride to Dubai Mall',
                            time: 'Today 11:49 am',
                            fare: 'INR 200',
                            status: 'Cancelled',
                            statusColor: Theme.of(context).colorScheme.error,
                            onTap: () {
                              context.pushNamed(AppRoute.rideDetailPage);
                            },
                            onStatusTap: () {
                              // Handle status click
                            },
                          ),
                          RideTile(
                            imagePath: AppImages.rides,
                            title: 'Ride to Mona',
                            time: 'Today 11:31 am',
                            fare: 'INR 200',
                            status: 'Cancelled',
                            statusColor: Theme.of(context).colorScheme.error,
                            onTap: () {
                              context.pushNamed(AppRoute.rideDetailPage);
                            },
                            onStatusTap: () {
                              // Handle status click
                            },
                          ),
                          Text(
                            "Tuesday 20, July",
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RideTile(
                            imagePath: AppImages.rides,
                            title: 'Executive Ride',
                            time: 'Today 11:49 am',
                            fare: 'INR 200',
                            status: 'Cancelled',
                            statusColor: Theme.of(context).colorScheme.error,
                            onTap: () {
                              context.pushNamed(AppRoute.rideDetailPage);
                            },
                            onStatusTap: () {
                              // Handle status click
                            },
                          ),
                        ],
                      ),
                    ),
                    Center(
                        child: Text(
                      'Pay As You Go',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                    Center(
                        child: Text(
                      'Coming Soon',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
