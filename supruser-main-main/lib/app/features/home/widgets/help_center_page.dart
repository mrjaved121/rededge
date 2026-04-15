import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
                      "Help Center",
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
                            "Get help with recent activity",
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.rides),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ride to Dubai Mall ',
                                      style: textTheme(context)
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Today 11:49 am',
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darkGrey
                                                  .withOpacity(0.8)),
                                    ),
                                    Text(
                                      'INR 200',
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.darkGrey
                                                  .withOpacity(0.8)),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.timer_outlined,
                                            size: 20,
                                            color: AppColors.darkGrey
                                                .withOpacity(0.8)),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Coming up',
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              context.pushNamed(AppRoute.activitiesPage);
                            },
                            child: _buildHelpItem(
                              'Show More Activities',
                            ),
                          ),
                          _buildHelpItem(
                            "I can't change my account currency",
                          ),
                          _buildHelpItem(
                              "I am unable to edit my account details"),
                          _buildHelpItem(
                              "I don't see an option for biometrics authentication"),
                          const SizedBox(height: 20),
                          const SizedBox(height: 10),
                          Text(
                            "Support inbox",
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          ListTile(
                            leading: const Icon(Icons.mail_outline),
                            title: Text(
                              "Read messages",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Help topics",
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          ListTile(
                            title: Text(
                              "About Supr",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          ListTile(
                            title: Text(
                              "Sign up and manage account",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          ListTile(
                            title: Text(
                              "Biometric Authentication",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
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
                            "Get help with recent activity",
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.rides),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ride to Dubai Mall ',
                                      style: textTheme(context)
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Today 11:49 am',
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darkGrey
                                                  .withOpacity(0.8)),
                                    ),
                                    Text(
                                      'INR 200',
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.darkGrey
                                                  .withOpacity(0.8)),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.timer_outlined,
                                            size: 20,
                                            color: AppColors.darkGrey
                                                .withOpacity(0.8)),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Coming up',
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _buildHelpItem(
                            "I want to know supr rates",
                          ),
                          _buildHelpItem("Issue with upcoming/ ongoing Rides"),
                          _buildHelpItem("Other Reason"),
                          const SizedBox(height: 20),
                          const SizedBox(height: 10),
                          Text(
                            "Support inbox",
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          ListTile(
                            leading: const Icon(Icons.mail_outline),
                            title: Text(
                              "Read messages",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Help topics",
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          ListTile(
                            title: Text(
                              "Rides",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          ListTile(
                            title: Text(
                              "Flexi Go",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          ListTile(
                            title: Text(
                              "Safety & Security",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
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
                            "Help with Supr Pay",
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          _buildHelpItem(
                            "Issue with wallets or adding credits",
                          ),
                          _buildHelpItem("Issue with sending money"),
                          _buildHelpItem("Issue with adding card"),
                          const SizedBox(height: 20),
                          const SizedBox(height: 10),
                          Text(
                            "Support inbox",
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          ListTile(
                            leading: const Icon(Icons.mail_outline),
                            title: Text(
                              "Read messages",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Help topics",
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          ListTile(
                            title: Text(
                              "Debit and Credit Cards",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          ListTile(
                            title: Text(
                              "Temporary authorization hold",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          const Divider(
                            color: AppColors.appGrey,
                          ),
                          ListTile(
                            title: Text(
                              "Pay Someone",
                              style: textTheme(context)
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.arrow_forward, size: 16),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          ),
                        ],
                      ),
                    ),
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
