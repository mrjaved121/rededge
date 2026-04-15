import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/core/theme/color_scheme.dart';
import 'package:suprapp/app/features/auth/pages/biometric_setup_page.dart';
import 'package:suprapp/app/features/dine_out/controller/state_controller.dart';
import 'package:suprapp/app/features/dine_out/widgets/custom_bottomsheett_subscription.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class CareemPlusScreen extends StatefulWidget {
  const CareemPlusScreen({super.key});

  @override
  State<CareemPlusScreen> createState() => _CareemPlusScreenState();
}

class _CareemPlusScreenState extends State<CareemPlusScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final provider = Provider.of<AppBarProvider>(context, listen: false);
      if (_scrollController.offset > 100) {
        provider.setCollapsed(true);
      } else {
        provider.setCollapsed(false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void showSubscriptionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SubscriptionBottomSheet(
        onSubscribe: () {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Subscribed to Careem Plus!')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarProvider = Provider.of<AppBarProvider>(context);
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 80,
            child: Row(
              children: [
                const Icon(Icons.percent, size: 15),
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.offer);
                  },
                  child: Text(
                    "Offer",
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface.withOpacity(0.7)),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 15,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.07,
                child: CustomElevatedButton(
                    text: "Subscribe Now", onPressed: () {})),
          )
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
              forceMaterialTransparency: true,
              pinned: true,
              floating: false,
              expandedHeight: 200,
              backgroundColor: appBarProvider.isCollapsed
                  ? Colors.white
                  : colorScheme(context).primary,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: colorScheme(context).surface,
                        borderRadius: BorderRadius.circular(7)),
                    child: Icon(
                      Icons.arrow_back,
                      color: colorScheme(context).onSurface,
                      size: 20,
                    ),
                  ),
                ),
              ),
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                final isCollapsed = constraints.maxHeight <=
                    kToolbarHeight + MediaQuery.of(context).padding.top;

                return FlexibleSpaceBar(
                  title: isCollapsed
                      ? Text(
                          "Join Supr Plus",
                          style: textTheme(context)
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                      : null,
                  background: Container(
                    color: colorScheme(context).primary,
                    padding:
                        const EdgeInsets.only(top: 60, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Start saving today',
                          style: textTheme(context).bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).onPrimary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Supr+ ",
                          style: textTheme(context).displayLarge?.copyWith(
                              fontSize: 32,
                              color: AppColors.brightGreen,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Text('DineOut | Rides | Food | More',
                            style: textTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).onPrimary)),
                        const SizedBox(height: 4),
                        Text(
                          'AED 15/month',
                          style: textTheme(context).bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).onPrimary),
                        ),
                      ],
                    ),
                  ),
                );
              })),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _buildBenefitTile(
                        title: 'Buy 1 Get 1 deals & more',
                        subtitle: 'Save across 800+ dining places',
                        badge: 'Featuring brunches, buffets, and more',
                        icon: Icons.restaurant_menu,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Text(
                    "Have a question",
                    style: textTheme(context)
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  customTile("Frequently asked questions", () {
                    context.pushNamed(AppRoute.faqsPage);
                  }),
                  customTile("T&Cs apply", () {
                    context.pushNamed(AppRoute.termsConditionPage);
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitTile({
    required String title,
    required String subtitle,
    IconData? icon,
    String? badge,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading:
              Icon(Icons.check_circle, color: colorScheme(context).primary),
          title: Text(title,
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          subtitle: Text(
            subtitle,
            style: textTheme(context).bodySmall,
          ),
        ),
        const SizedBox(width: 12),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.brightGreen.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              badge!,
              style: textTheme(context)
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget customTile(
    String title,
    VoidCallback onTpa,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style:
            textTheme(context).bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.arrow_forward_outlined,
        size: 20,
      ),
      onTap: onTpa,
    );
  }
}
