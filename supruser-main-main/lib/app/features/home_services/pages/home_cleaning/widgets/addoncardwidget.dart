import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';
import '../provider/home_cleaing_provider.dart';

class AddOnCardWidget extends StatelessWidget {
  final AddOnService addOn;
  final BookingProvider provider;
  final VoidCallback? onLearnMore;

  const AddOnCardWidget({
    super.key,
    required this.addOn,
    required this.provider,
    this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Provider se live data fetch karo with Listener
    return Listener(
      onPointerDown: (_) {
        // Force rebuild when interaction happens
        provider.notifyListeners();
      },
      child: Consumer<BookingProvider>(
        builder: (context, bookingProvider, _) {
          // ✅ Debugging: Print karo state
          print("🔍 AddOn: ${addOn.title}, Selected: ${bookingProvider.isAddOnSelected(addOn)}, Qty: ${bookingProvider.getAddOnQuantity(addOn)}");

          final isSelected = bookingProvider.isAddOnSelected(addOn);
          final quantity = bookingProvider.getAddOnQuantity(addOn);

          return SizedBox(
            width: ResponsiveUtils.wp(context, 38),
            height: ResponsiveUtils.hp(context, 29),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Card Container
                Container(
                  height: ResponsiveUtils.hp(context, 27),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: isSelected ? AppColors.darkGreens : AppColors.appGrey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 7.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Container
                      Container(
                        height: ResponsiveUtils.hp(context, 8),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              ResponsiveUtils.getBorderRadius(context, 7.2),
                            ),
                            topRight: Radius.circular(
                              ResponsiveUtils.getBorderRadius(context, 7.2),
                            ),
                          ),
                        ),
                        child: Center(
                          child: _getAddOnIcon(addOn.image, context),
                        ),
                      ),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(
                            ResponsiveUtils.getSpacing(context, 9.6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                addOn.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.sp(context, 12),
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 4)),

                              // Description
                              Text(
                                addOn.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.sp(context, 11),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 6)),

                              // Learn More
                              InkWell(
                                onTap: onLearnMore ?? () {},
                                child: Text(
                                  "Learn more",
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.sp(context, 11),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brightGreen,
                                  ),
                                ),
                              ),

                              SizedBox(height: ResponsiveUtils.getSpacing(context, 15)),

                              // Price
                              Row(
                                children: [
                                  Text(
                                    "AED ${addOn.price.toInt()}",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.sp(context, 13.8),
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: ResponsiveUtils.getSpacing(context, 4.8)),
                                  Text(
                                    "AED ${addOn.originalPrice.toInt()}",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.sp(context, 10.4),
                                      color: AppColors.darkGrey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ Button positioned at bottom border
                Positioned(
                  bottom: ResponsiveUtils.hp(context, 2) - (ResponsiveUtils.getSpacing(context, 33) / 2),
                  left: ResponsiveUtils.getSpacing(context, 16),
                  right: ResponsiveUtils.getSpacing(context, 16),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: isSelected
                        ? _buildQuantityCounter(context, quantity, bookingProvider)
                        : _buildAddButton(context, bookingProvider),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ✅ Add Button
  Widget _buildAddButton(BuildContext context, BookingProvider provider) {
    return Container(
      key: ValueKey("add_${addOn.title}"),
      height: ResponsiveUtils.getSpacing(context, 28),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 6),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print("✅ Add clicked for: ${addOn.title}");
            provider.addAddOn(addOn);
            // ✅ Force rebuild
            provider.notifyListeners();
          },
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 6),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.getSpacing(context, 12),
              vertical: ResponsiveUtils.getSpacing(context, 4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  size: 20,
                  color: AppColors.lightGreen,
                ),
                SizedBox(width: 2),
                Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Quantity Counter
  Widget _buildQuantityCounter(BuildContext context, int quantity, BookingProvider provider) {
    return Container(
      key: ValueKey("counter_${addOn.title}"),
      height: ResponsiveUtils.getSpacing(context, 28),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 6),
        ),
      ),
      child: Row(
        children: [
          // ✅ Minus/Delete Button with animation
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print(quantity > 1 ? "➖ Decrease clicked for: ${addOn.title}" : "🗑️ Delete clicked for: ${addOn.title}");
                  provider.decreaseAddOnQuantity(addOn);
                  provider.notifyListeners();
                },
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    ResponsiveUtils.getBorderRadius(context, 6),
                  ),
                  bottomLeft: Radius.circular(
                    ResponsiveUtils.getBorderRadius(context, 6),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.backgroundGrey, width: 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        ResponsiveUtils.getBorderRadius(context, 6),
                      ),
                      bottomLeft: Radius.circular(
                        ResponsiveUtils.getBorderRadius(context, 6),
                      ),
                    ),
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: Icon(
                        quantity > 1 ? Icons.remove : Icons.delete_outline,
                        key: ValueKey(quantity > 1 ? "remove" : "delete"),
                        size: 16,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Quantity Display
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              quantity.toString(),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: AppColors.darkGreen,
              ),
            ),
          ),

          // Plus Button
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print("➕ Increase clicked for: ${addOn.title}");
                  provider.increaseAddOnQuantity(addOn);
                  provider.notifyListeners();
                },
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    ResponsiveUtils.getBorderRadius(context, 6),
                  ),
                  bottomRight: Radius.circular(
                    ResponsiveUtils.getBorderRadius(context, 6),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.backgroundGrey, width: 1),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        ResponsiveUtils.getBorderRadius(context, 6),
                      ),
                      bottomRight: Radius.circular(
                        ResponsiveUtils.getBorderRadius(context, 6),
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAddOnIcon(String type, BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case "balcony":
        icon = Icons.balcony;
        color = AppColors.appGreen;
        break;
      case "ironing":
        icon = Icons.iron;
        color = Colors.blue;
        break;
      case "fridge":
        icon = Icons.kitchen;
        color = Colors.lightBlue;
        break;
      case "wardrobe":
        icon = Icons.checkroom;
        color = Colors.brown;
        break;
      default:
        icon = Icons.cleaning_services;
        color = AppColors.appGreen;
    }

    return Icon(
      icon,
      size: ResponsiveUtils.getIconSize(context, base: 36),
      color: color,
    );
  }
}
