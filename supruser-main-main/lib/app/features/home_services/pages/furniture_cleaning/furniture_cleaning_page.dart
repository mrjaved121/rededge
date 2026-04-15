// File: furniture_cleaning_page.dart

import 'package:flutter/material.dart';
import '../../mixservicesmainetailpage/servicedetailcontent.dart';

class FurnitureCleaningPage extends StatelessWidget {
  const FurnitureCleaningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ServiceDetailsContent(
      categoryId: 'furniture_cleaning',
    );
  }
}