import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/bike_ride/sheets/bike_bottom_sheet.dart';
import 'package:suprapp/app/features/bike_ride/sheets/select_time_sheet.dart';
import 'package:suprapp/app/features/rides/provider/date_provider.dart';
import 'package:suprapp/app/features/rides/provider/saved_favorit_location.dart';
import 'package:suprapp/app/features/rides/widgets/nested_bottom_sheets.dart';
import 'package:suprapp/app/features/rides/widgets/selected_date.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class SelectDateSheet extends StatefulWidget {
  final VoidCallback onScrollUp;
  const SelectDateSheet({super.key, required this.onScrollUp});

  @override
  State<SelectDateSheet> createState() => _SelectDateSheetState();
}

class _SelectDateSheetState extends State<SelectDateSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.size > 0.5) {
        widget.onScrollUp();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      snap: true,
      snapSizes: const [0.4, 0.8],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Date',
                            style: textTheme(context)
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Consumer<PickupTimeProvider>(
                            builder: (context, provider, _) {
                              return GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (_) => const SelectTimeSheet(),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: colorScheme(context).primary,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        provider.selectedDay == null
                                            ? 'Select Pickup Time'
                                            : provider.displayTime,
                                        style: textTheme(context)
                                            .labelLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.12),
                          child: Icon(
                            Icons.location_on,
                            color: colorScheme(context).primary,
                          ),
                        ),
                        title: Text(
                          'Tahir Qadri Abayat ',
                          style: textTheme(context)
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '62 - 67 - 4 - Business Bay - Dubai',
                          style: textTheme(context).bodyMedium,
                        ),
                        trailing: Consumer<SavedLocationProvider>(
                          builder: (context, savedLocationProvider, _) {
                            final isSaved = savedLocationProvider.isSaved;

                            return IconButton(
                              icon: Icon(
                                isSaved
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: isSaved ? Colors.red : Colors.grey,
                                size: 24,
                              ),
                              onPressed: () {
                                if (!isSaved) {
                                  savedLocationProvider.saveLocation();

                                  context.pushNamed(AppRoute.savedLocationPage);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Remove Location'),
                                        content: const Text(
                                            'Do you want to remove this saved location?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context), // Cancel
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              savedLocationProvider
                                                  .removeLocation();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomElevatedButton(
                        text: 'Confirm Pickup',
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return const BikeBottomSheet();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
