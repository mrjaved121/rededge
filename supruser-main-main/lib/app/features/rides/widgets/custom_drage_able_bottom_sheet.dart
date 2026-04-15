import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/provider/bottom_sheet_provider.dart';
import 'package:suprapp/app/features/rides/provider/favorite_provider.dart';
import 'package:suprapp/app/features/rides/provider/map_provider.dart';
import 'package:suprapp/app/features/rides/widgets/custom_arrow_down.dart';
import 'package:suprapp/app/features/rides/widgets/custom_dialog.dart';
import 'package:suprapp/app/features/rides/widgets/new_bottom_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool hasText = false;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BottomSheetProvider>(context, listen: false)
          .initialize(context);
    });

    controller.addListener(() {
      final text = controller.text.trim();
      setState(() {
        hasText = text.isNotEmpty;
      });
      if (text.isNotEmpty) {
        Provider.of<MapProvider>(context, listen: false).searchPlaces(text);
      } else {
        Provider.of<MapProvider>(context, listen: false).clear();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Map<String, String>> items = [
    {'title': 'Mona', 'subtitle': '62 - 67 - 4 - Business Bay - Dubai'},
    {'title': 'Mona', 'subtitle': '62 - 67 - 4 - Business Bay - Dubai'},
  ];

  void _showNewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => NewBottomSheet(
        onScrollUp: () {
          Provider.of<BottomSheetProvider>(context, listen: false)
              .controller
              .animateTo(
                1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
          context.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    return Consumer<BottomSheetProvider>(
      builder: (context, provider, _) {
        return DraggableScrollableSheet(
          controller: provider.controller,
          initialChildSize: 0.3,
          minChildSize: 0.3,
          maxChildSize: 1.0,
          snap: true,
          snapSizes: const [0.3, 1.0],
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _BottomSheetHeaderDelegate(
                      isExpanded: provider.isExpanded,
                      onToggle: provider.toggleBottomSheet,
                      controller: controller,
                      buttontab: () {
                        provider.controller.animateTo(
                          0.3,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      hasText: hasText,
                    ),
                  ),
                  if (hasText)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final isFav = favProvider.isFavorite(index);
                          final name = items[index]['title'] ?? 'Unknown';
                          final address = items[index]['subtitle'] ?? '';

                          return ListTile(
                            leading: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: colorScheme(context).primary,
                                  size: 15,
                                ),
                              ),
                            ),
                            title:
                                Text(name, style: textTheme(context).bodyLarge),
                            subtitle: Text(address,
                                style: textTheme(context).bodyLarge),
                            trailing: IconButton(
                              icon: isFav
                                  ? Icon(Icons.favorite,
                                      size: 20,
                                      color: colorScheme(context).primary)
                                  : const Icon(Icons.favorite_outline,
                                      size: 20),
                              onPressed: () {
                                if (!isFav) {
                                  favProvider.addFavorite(index);
                                  context.pushNamed(AppRoute.savedLocationPage);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ConfirmDeleteDialog(
                                      title:
                                          'Are you sure you want to remove this saved location?',
                                      onNo: () => Navigator.pop(context),
                                      onYes: () {
                                        favProvider.removeFavorite(index);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              controller.clear();
                              // Scroll the current bottom sheet down
                              provider.controller.animateTo(
                                0.3,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              // Show the new bottom sheet
                              _showNewBottomSheet(context);
                            },
                          );
                        },
                        childCount: items.length,
                      ),
                    ),
                  if (!hasText && provider.isExpanded)
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.3)),
                              child: Icon(Icons.search,
                                  size: 25,
                                  color: colorScheme(context).primary),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              "Where do you want to go ?",
                              style: textTheme(context)
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                                "Enter your destination in the search area \nabove to find your location.",
                                textAlign: TextAlign.center,
                                style: textTheme(context).bodyMedium),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CustomElevatedButton(
                                text: "Select Location on map",
                                onPressed: () {
                                  provider.controller.animateTo(
                                    0.3,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3))),
                              child: Center(
                                  child: Text(
                                "Skip destination step",
                                style: textTheme(context)
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _BottomSheetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final bool isExpanded;
  final VoidCallback onToggle;
  final TextEditingController controller;
  final VoidCallback buttontab;
  final bool hasText;

  _BottomSheetHeaderDelegate({
    required this.isExpanded,
    required this.onToggle,
    required this.controller,
    required this.buttontab,
    required this.hasText,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isExpanded)
            Align(
                alignment: Alignment.topLeft,
                child: CustomArrowDown(onTap: onToggle)),
          if (!isExpanded)
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          if (!isExpanded)
            Text(
              'Where To ?',
              style: textTheme(context)
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 15),
          CustomTextFormField(
            controller: controller,
            prefixIcon: AppIcon.searchIcon,
            hint: "Enter Your Destination",
            hintSize: 15,
            hintColor: Colors.grey,
            focusBorderColor: Colors.grey.withOpacity(0.3),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '|',
                    style: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.2),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Dubai",
                    style: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.2),
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoute.searchCityPage);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: colorScheme(context).onSurface.withOpacity(0.2),
                      size: 23,
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

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(_BottomSheetHeaderDelegate oldDelegate) {
    return oldDelegate.isExpanded != isExpanded ||
        oldDelegate.hasText != hasText;
  }
}
