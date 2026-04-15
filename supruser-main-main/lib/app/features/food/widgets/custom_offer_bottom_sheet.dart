import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class OfferBottomSheet extends StatelessWidget {
  const OfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcon.offer,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 8),
              Text("Offer",
                  style: textTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.carmineRed)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: const Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text("Offer",
              style: textTheme(context)
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Crazy Deals: 50% off",
              style: textTheme(context).labelMedium?.copyWith(
                  color: AppColors.darkGrey, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("This discount is automatically applied at checkout",
                style: textTheme(context)
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _offerDetailTile("Min spend", "AED 0", context),
                Container(width: 1, height: 40, color: Colors.grey.shade300),
                _offerDetailTile("Max Discount", "Unlimited", context),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text("• Valid until orders above ",
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(color: Colors.black54)),
          Text("• Valid until 2025-05-18",
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(color: Colors.black54)),
          Text("• Maximum discount is AED 30",
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(color: Colors.black54)),
          Spacer(),
          CustomElevatedButton(
              text: "Got it",
              onPressed: () {
                context.pop();
              })
        ],
      ),
    );
  }

  Widget _offerDetailTile(String title, String value, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Text(
              title,
              style: textTheme(context).bodyMedium?.copyWith(
                  color: AppColors.darkGrey, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(value,
                style: textTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface))
          ],
        ),
      ),
    );
  }
}
