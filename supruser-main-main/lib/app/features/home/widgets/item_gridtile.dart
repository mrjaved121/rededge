import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class ItemGridTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final double tileWidth;
  final double imageScaleFactor;
  final VoidCallback? onTap;

  const ItemGridTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.tileWidth,
    this.imageScaleFactor = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final double maxImageSize = tileWidth * 0.6;
    // final double imageSize = maxImageSize * imageScaleFactor;
    final double fontSize = tileWidth * 0.11;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.fitHeight,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme(context).bodySmall?.copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff000000),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
