import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';

import '../../../core/constants/global_variables.dart';

class RestaurantCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final String tag;
  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.tag,
  });

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: isFavorite ? AppColors.appGreen : Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite_border : Icons.favorite_border,
                    color: isFavorite ? Colors.white : AppColors.darkGrey,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,
                    style: textTheme(context).titleLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.appOrange,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(widget.location,
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Text(widget.price,
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.appGreen,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(' Supr + | 10% Off on La-carte',
                  style: textTheme(context).bodySmall?.copyWith(
                      color: AppColors.lightGreen,
                      fontWeight: FontWeight.w600)),
            )
          ],
        )
      ],
    );
  }
}
