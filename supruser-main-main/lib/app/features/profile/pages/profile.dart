import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/core/constants/shared_pref.dart';
import 'package:suprapp/app/core/constants/static_data.dart';
import 'package:suprapp/app/core/utils/custom_snackbar.dart';
import 'package:suprapp/app/features/auth/provider/auth_provider.dart';
import 'package:suprapp/app/routes/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        surfaceTintColor: colorScheme(context).onPrimary,
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
                  border: Border.all(color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(7)),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.darkGrey,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(StaticData.model!.name,
                  style: textTheme(context)
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildSuprPlusCard(),
              const SizedBox(height: 24),
              _buildSection('Your account', [
                _buildSettingItem(
                  leading: const Icon(Icons.person_outline_outlined),
                  'Personal Information',
                  subtitle: StaticData.model!.phone,
                  onTap: () {
                    context.pushNamed(AppRoute.personalInfo);
                  },
                ),
                _buildSettingItem('Cards and accounts',
                    leading: const Icon(Icons.credit_card_outlined), onTap: () {
                  context.pushNamed(AppRoute.bankpage);
                }),
                _buildSettingItem('Saved addresses',
                    leading: const Icon(Icons.home), onTap: () {
                  context.pushNamed(AppRoute.savedAddressPage);
                }),
                _buildSettingItem('Notifications',
                    leading: const Icon(Icons.notifications_none_outlined),
                    onTap: () {
                  context.pushNamed(AppRoute.notificationpage);
                }),
                _buildSettingItem('Manage Business profile',
                    leading: const Icon(Icons.add_business_outlined),
                    onTap: () {
                  context.pushNamed(AppRoute.manageBusinessProfile);
                }),
              ]),
              const SizedBox(height: 24),
              _buildSection('Benefits', [
                _buildSettingItem(
                  'Supr Plus',
                  leading: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme(context).primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'S+',
                      style: textTheme(context).bodySmall?.copyWith(
                          color: colorScheme(context).onPrimary,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  subtitle: 'See the benefits',
                  onTap: () {
                    context.pushNamed(AppRoute.creamplusPage);
                  },
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Support', [
                _buildSettingItem(
                  leading: const Icon(Icons.headphones_outlined),
                  'Help Center',
                  onTap: () {
                    context.pushNamed(AppRoute.helpCenterPage);
                  },
                ),
                _buildSettingItem(
                  leading: const Icon(Icons.person_add_alt),
                  'Invite Friends',
                  onTap: () {
                    context.pushNamed(AppRoute.invitePage);
                  },
                ),
                _buildSettingItem(
                  leading: const Icon(Icons.star_border_sharp),
                  'Win Rewards',
                  onTap: () {
                    context.pushNamed(AppRoute.winRewardPage);
                  },
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Preferences', [
                _buildSettingItem(
                  leading: const Icon(Icons.language_outlined),
                  'Language',
                  subtitle: 'English',
                  onTap: () {
                    context.pushNamed(AppRoute.languagePage);
                  },
                ),
                _buildSettingItem(
                  leading: const Icon(Icons.flag_outlined),
                  'Country',
                  subtitle: 'United States of America',
                  onTap: () {
                    context.pushNamed(AppRoute.selectcCountryPage);
                  },
                ),
                _buildSettingItem(
                  leading: const Icon(Icons.settings),
                  'Settings',
                  onTap: () {
                    context.pushNamed(AppRoute.settingPage);
                  },
                ),
                _buildSettingItem(
                  leading: const Icon(Icons.settings_outlined),
                  'Account Setting',
                  onTap: () {
                    context.pushNamed(AppRoute.accountSettingPage);
                  },
                ),
                _buildSettingItem(
                  leading: const Icon(Icons.contacts_outlined),
                  'Terms and Conditions',
                  onTap: () {
                    context.pushNamed(AppRoute.termsConditionPage);
                  },
                ),
                _buildSettingItem(
                  leading: const Icon(Icons.logout),
                  'Logout',
                  onTap: () async {
                    context.loaderOverlay.show();

                    authProvider.logoutUser();

                    showSnackbar(
                      message: "Logout successful!",
                    );
                    context.loaderOverlay.hide();
                    context.pushReplacementNamed(AppRoute.splashScreen);
                  },
                ),
              ]),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme(context)
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }

  Widget _buildSettingItem(
    String title, {
    String? subtitle,
    Widget? leading,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
      title: Text(
        title,
        style: textTheme(context)
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: textTheme(context).bodyMedium?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.6)))
          : null,
      leading: leading,
      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
      onTap: onTap,
    );
  }

  Widget _buildSuprPlusCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme(context).primary,
            colorScheme(context).onSurface.withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Supr+',
                  style: textTheme(context).titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 27),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme(context).onPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Tap for instant help',
                      style: textTheme(context)
                          .bodySmall
                          ?.copyWith(color: colorScheme(context).onPrimary)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('Get more with Supr',
                style: textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: colorScheme(context).onPrimary)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('See the benefits',
                        style: textTheme(context).titleSmall?.copyWith(
                            color: colorScheme(context).onPrimary,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      'Save ₹1000+ per month\nStart Supr Plus Now',
                      style: textTheme(context)
                          .bodySmall
                          ?.copyWith(color: colorScheme(context).onPrimary),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme(context).onSurface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('See the Benefits',
                      style: textTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).onPrimary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
