import 'package:flutter/material.dart';

class ItemGridTileLargeImage extends StatelessWidget {
  final String imagePath;
  final String title;
  final double height;
  final double width;
  final VoidCallback? onTap;

  const ItemGridTileLargeImage({
    super.key,
    required this.imagePath,
    required this.title,
    this.height = 120,
    this.width = 120,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> titleWords = title.split(" ");

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          // color: const Color(0xFFF8F2E5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(imagePath, fit: BoxFit.fill),
            ),
      ),
    );
  }
}