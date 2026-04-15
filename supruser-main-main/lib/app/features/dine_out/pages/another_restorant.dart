import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/dine_out/controller/dine_out_provider.dart';
import 'package:suprapp/app/features/dine_out/widgets/opening_hour_bottom_sheet.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class AnotherRestorantScreen extends StatefulWidget {
  final int parentIndex;
  final int childIndex;
  const AnotherRestorantScreen({
    super.key,
    required this.childIndex,
    required this.parentIndex,
  });

  @override
  State<AnotherRestorantScreen> createState() => _AnotherRestorantScreenState();
}

class _AnotherRestorantScreenState extends State<AnotherRestorantScreen> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startImageCarousel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startImageCarousel() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        final provider = Provider.of<DineOutProvider>(context, listen: false);
        final data =
            provider.getAnotherByIndex(widget.parentIndex, widget.childIndex);
        final imageModel = data.image.isNotEmpty ? data.image[0] : null;
        final imageList = imageModel != null
            ? [
                imageModel.image1,
                imageModel.image2,
                imageModel.image3,
                imageModel.image4,
                imageModel.image5,
                imageModel.image6,
                imageModel.image7,
                imageModel.image8,
              ].where((img) => img.isNotEmpty).toList()
            : [AppImages.eggtranding];
        _currentIndex = (_currentIndex + 1) % imageList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DineOutProvider>(context);
    final data =
        provider.getAnotherByIndex(widget.parentIndex, widget.childIndex);
    final imageModel = data.image.isNotEmpty ? data.image[0] : null;
    final imageList = imageModel != null
        ? [
            imageModel.image1,
            imageModel.image2,
            imageModel.image3,
            imageModel.image4,
            imageModel.image5,
            imageModel.image6,
            imageModel.image7,
            imageModel.image8,
          ].where((img) => img.isNotEmpty).toList()
        : [AppImages.eggtranding];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            floating: false,
            actions: [
              customIconContainer(Icons.share_outlined, () {}),
              const SizedBox(width: 10),
              customIconContainer(Icons.favorite_outline, () {}),
              const SizedBox(width: 10),
            ],
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
            backgroundColor: colorScheme(context).onPrimary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(10),
              title: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final isCollapsed = constraints.maxHeight <=
                      kToolbarHeight + MediaQuery.of(context).padding.top;

                  return isCollapsed
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (_) => OpeningHoursBottomSheet(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: colorScheme(context).primary,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Open until 1:30 AM",
                                      style: textTheme(context)
                                          .labelSmall
                                          ?.copyWith(
                                              color: Colors.white, fontSize: 7),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down,
                                        size: 10, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: colorScheme(context).primary,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.photo_camera_outlined,
                                      size: 10, color: Colors.white),
                                  Text(
                                    "${_currentIndex + 1} of ${imageList.length}",
                                    style: textTheme(context)
                                        .labelSmall
                                        ?.copyWith(
                                            color: Colors.white, fontSize: 7),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                },
              ),
              background: Stack(
                fit: StackFit.expand,
                children: List.generate(imageList.length, (index) {
                  return AnimatedOpacity(
                    opacity: _currentIndex == index ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      imageList[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print(
                            "Error loading image: ${imageList[index]}"); // Debug log
                        return Image.asset(
                          AppImages.eggtranding,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: textTheme(context)
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.location,
                      style: textTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: colorScheme(context).primary, size: 16),
                        Text(
                          "${data.rating} (2454 ratings on google)",
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    _careemPlusCard(context),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _actionButton(
                            Icons.location_on_outlined, "Map", () {}, context),
                        const SizedBox(width: 10),
                        _actionButton(Icons.directions_car_outlined,
                            "Book a ride", () {}, context),
                        const SizedBox(width: 10),
                        _actionButton(
                            Icons.call_outlined, "Call", () {}, context),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Go for their samosas",
                      style: textTheme(context)
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.restaurant_menu_outlined,
                          size: 18,
                          color: AppColors.darkGrey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Cafe",
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.payments_outlined,
                          size: 18,
                          color: AppColors.darkGrey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Average cost of AED 45 for one",
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).onSurface),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _menuCard(() {
                      context.pushNamed(AppRoute.menu);
                    }, context),
                    const SizedBox(height: 10),
                    customTile("Photos", () {
                      context.pushNamed(AppRoute.restaurentPhotosPage);
                    }, context),
                    const SizedBox(height: 16),
                    customPhotos(context),
                    customTile("Useful bits", () {
                      context.pushNamed(AppRoute.usefull);
                    }, context),
                    Divider(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Amenities",
                      style: textTheme(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Indoor Seating, Parking Availability (Paid, Outdoor/Street), Wheelchair Accessible, Outdoor Seating, Kid Friendly",
                      style: textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.black.withOpacity(0.6)),
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "House Rules",
                      style: textTheme(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Dress Code, Casual, Family Friendly",
                      style: textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.black.withOpacity(0.6)),
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                        text: "Subscribe to supr plus now",
                        onPressed: () {
                          context.pushNamed(AppRoute.creamplusPage);
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _careemPlusCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme(context).primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Stack(
            children: [
              Text(
                "Supr+ |",
                style: textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: AppColors.brightGreen),
              ),
            ],
          ),
          Text(
            " Subscribe to get",
            style: textTheme(context).bodyMedium?.copyWith(color: Colors.white),
          ),
          Text(
            " 10% off",
            style: textTheme(context)
                .bodyMedium
                ?.copyWith(color: AppColors.brightGreen),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward,
              color: AppColors.brightGreen, size: 16),
        ],
      ),
    );
  }

  Widget _actionButton(
      IconData icon, String label, VoidCallback onTap, BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 18,
          color: Colors.black.withOpacity(0.4),
        ),
        label: Text(
          label,
          style: textTheme(context).labelLarge?.copyWith(
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _menuCard(VoidCallback onTap, BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 232, 232, 232)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: const Icon(Icons.menu_book_outlined,
            color: Color.fromARGB(255, 63, 63, 63)),
      ),
      title: Text(
        "View menu",
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Bon appetit!",
          style: textTheme(context)
              .labelLarge
              ?.copyWith(color: Colors.black.withOpacity(0.7))),
      onTap: onTap,
    );
  }

  Widget customIconContainer(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget customTile(String title, VoidCallback onTap, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: textTheme(context)
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(
        Icons.arrow_forward_outlined,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  Widget customPhotos(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AppImages.eggtranding,
              height: 120,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.eggtranding,
                      cacheHeight: 70,
                      cacheWidth: 150,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.eggtranding,
                      cacheHeight: 70,
                      cacheWidth: 150,
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AppImages.eggtranding,
                  cacheHeight: 150,
                  cacheWidth: 150,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
