// ==================== DYNAMIC SPLASH SCREEN (NO ANIMATION + CUSTOM APPBAR) ====================
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../features/home_services/pages/home_cleaning/widgets/customappbar.dart'; // 👈 Import CustomAppBar
import 'model/service_model.dart';

class DynamicSplashScreen extends StatefulWidget {
  final ServiceModel service;
  final Widget targetPage;

  const DynamicSplashScreen({
    super.key,
    required this.service,
    required this.targetPage,
  });

  @override
  State<DynamicSplashScreen> createState() => _DynamicSplashScreenState();
}

class _DynamicSplashScreenState extends State<DynamicSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate automatically after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => widget.targetPage),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Clean service title (remove any new lines)
    String cleanTitle = widget.service.title.replaceAll('\n', ' ');

    return Scaffold(
      backgroundColor: AppColors.white,

      // ✅ Use CustomAppBar with dynamic title
      appBar: CustomAppBar(
        showBackButton: true,
        title: cleanTitle,
      ),

      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: ResponsiveUtils.hp(context, 5)),

              // ✅ Directly show the image (no animation)
              _buildCleaningIcon(context),

              SizedBox(height: ResponsiveUtils.hp(context, 4)),
              Text(
                cleanTitle,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 28),
                  fontWeight: FontWeight.w900,
                  color: AppColors.darkGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUtils.hp(context, 1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "powered by ",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 16),
                      color: AppColors.darkGrey,
                    ),
                  ),
                  Text(
                    "justlife",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.appGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ✅ Fixed Blue Bottom Shape
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: ResponsiveUtils.hp(context, 25),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1), // Fixed blue color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.getBorderRadius(context, 40)),
                  topRight: Radius.circular(ResponsiveUtils.getBorderRadius(context, 40)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cleaning icon layout (same as before)
  Widget _buildCleaningIcon(BuildContext context) {
    return Container(
      height: ResponsiveUtils.hp(context, 35),
      width: ResponsiveUtils.wp(context, 75),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Washing Machine
          Positioned(
            left: ResponsiveUtils.wp(context, 10),
            child: Container(
              width: ResponsiveUtils.wp(context, 35),
              height: ResponsiveUtils.hp(context, 18),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(ResponsiveUtils.getBorderRadius(context, 12)),
                border: Border.all(color: AppColors.appGrey, width: 2),
              ),
              child: Column(
                children: [
                  SizedBox(height: ResponsiveUtils.hp(context, 1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: ResponsiveUtils.wp(context, 3),
                        height: ResponsiveUtils.hp(context, 0.5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        width: ResponsiveUtils.wp(context, 2),
                        height: ResponsiveUtils.hp(context, 1),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: ResponsiveUtils.wp(context, 2),
                        height: ResponsiveUtils.hp(context, 1),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveUtils.hp(context, 2)),
                  Container(
                    width: ResponsiveUtils.wp(context, 22),
                    height: ResponsiveUtils.wp(context, 22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400, width: 3),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Container(
                        width: ResponsiveUtils.wp(context, 12),
                        height: ResponsiveUtils.wp(context, 12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF4A5568),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Towels
          Positioned(
            bottom: ResponsiveUtils.hp(context, 8),
            left: ResponsiveUtils.wp(context, 5),
            child: Container(
              width: ResponsiveUtils.wp(context, 18),
              height: ResponsiveUtils.hp(context, 3),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.appGrey),
              ),
            ),
          ),
          Positioned(
            bottom: ResponsiveUtils.hp(context, 5),
            left: ResponsiveUtils.wp(context, 8),
            child: Container(
              width: ResponsiveUtils.wp(context, 18),
              height: ResponsiveUtils.hp(context, 3),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.appGrey),
              ),
            ),
          ),
          Positioned(
            bottom: ResponsiveUtils.hp(context, 2),
            left: ResponsiveUtils.wp(context, 11),
            child: Container(
              width: ResponsiveUtils.wp(context, 6),
              height: ResponsiveUtils.hp(context, 3),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1), // Fixed blue
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Broom
          Positioned(
            right: ResponsiveUtils.wp(context, 15),
            bottom: 0,
            child: Container(
              width: ResponsiveUtils.wp(context, 8),
              height: ResponsiveUtils.hp(context, 25),
              child: Column(
                children: [
                  Container(
                    width: ResponsiveUtils.wp(context, 2),
                    height: ResponsiveUtils.hp(context, 17),
                    decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: ResponsiveUtils.wp(context, 8),
                    height: ResponsiveUtils.hp(context, 8),
                    decoration: BoxDecoration(
                      color: AppColors.appGreen,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
                        bottomRight: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20)),
                        topLeft: Radius.circular(ResponsiveUtils.getBorderRadius(context, 10)),
                        topRight: Radius.circular(ResponsiveUtils.getBorderRadius(context, 10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
