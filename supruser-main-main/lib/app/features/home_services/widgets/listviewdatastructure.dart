import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../Serviesdatamodel/servvices_datamodel.dart';
import '../pages/home_cleaning/provider/home_cleaing_provider.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    final isAdded = provider.isServiceSelected(service);
    final quantity = provider.getServiceQuantity(service);

    // ✅ Check if max quantity reached
    final isMaxReached = quantity >= service.maxQuantity;

    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.appGrey.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isAdded)
              Container(
                width: 3.5,
                decoration: BoxDecoration(
                  color: AppColors.appGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            width: 68,
                            height: 68,
                            color: AppColors.lightGrey,
                            child: Image.asset(
                              service.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.spa,
                                    color: AppColors.darkGrey, size: 27);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (isAdded)
                                    Padding(
                                      padding: EdgeInsets.only(right: 6),
                                      child: Text(
                                        '${quantity}x',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.appGreen,
                                        ),
                                      ),
                                    ),

                                  Expanded(
                                    child: Text(
                                      service.name,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),

                              Text(
                                service.description,
                                style: TextStyle(
                                    fontSize: 10, color: AppColors.darkGrey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.only(left: 78),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'AED ${service.price}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'AED ${service.originalPrice}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.darkGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),

                          isAdded
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ✅ Minus/Delete Button
                              Container(
                                height: 33,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.lightdarkmix,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: IconButton(
                                  onPressed: () => provider
                                      .decreaseServiceQuantity(service),
                                  icon: Icon(
                                    quantity > 1
                                        ? Icons.remove
                                        : Icons.delete_outline,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  constraints: BoxConstraints(minWidth: 25),
                                ),
                              ),

                              // ✅ Quantity
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              // ✅ Plus Button - DISABLED if max reached
                              Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isMaxReached
                                        ? AppColors.appGrey.withOpacity(0.5)
                                        : AppColors.lightdarkmix,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                  color: isMaxReached
                                      ? AppColors.lightGrey.withOpacity(0.3)
                                      : Colors.transparent,
                                ),
                                child: IconButton(
                                  onPressed: isMaxReached
                                      ? null // ⬅️ DISABLED
                                      : () => provider.increaseServiceQuantity(service),
                                  icon: Icon(
                                    Icons.add,
                                    color: isMaxReached
                                        ? AppColors.darkGrey.withOpacity(0.5)
                                        : Colors.black,
                                    size: 18,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  constraints: BoxConstraints(minWidth: 25),
                                ),
                              ),
                            ],
                          )
                              : ElevatedButton(
                            onPressed: () => provider.addService(service),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkGreen,
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add,
                                    color: AppColors.lightGreen, size: 15),
                                SizedBox(width: 3),
                                Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightGreen,
                                  ),
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
          ],
        ),
      ),
    );
  }
}
