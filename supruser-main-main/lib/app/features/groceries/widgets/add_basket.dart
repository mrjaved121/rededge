import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/groceries/controllers/product_quantity_provider.dart';

class FloatingBasketButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String totalAmout;

  const FloatingBasketButton({super.key, this.onTap, required this.totalAmout});

  @override
  Widget build(BuildContext context) {
    final totalItems = context.watch<QuantityProvider>();
    if (totalItems == 0) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.hardGreen,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add to Basket",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme(context).primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'items ${totalItems.totalUniqueItems}',
                    style: TextStyle(
                      color: colorScheme(context).onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'ABE :$totalAmout',
                  style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).surface,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
