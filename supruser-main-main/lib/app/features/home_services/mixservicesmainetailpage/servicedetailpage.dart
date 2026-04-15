import 'package:flutter/material.dart';
import 'package:suprapp/app/features/home_services/mixservicesmainetailpage/servicedetailcontent.dart';
import '../Serviesdatamodel/servvices_datamodel.dart';


class ServiceDetailsPage extends StatelessWidget {
  final String? categoryId;
  final ServiceCategory? category;

  const ServiceDetailsPage({
    super.key,
    this.categoryId,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    // Priority 1: If categoryId is provided (from SalonSpaPage)
    if (categoryId != null) {
      return ServiceDetailsContent(categoryId: categoryId!);
    }

    //  Priority 2: If category object is passed
    if (category != null) {
      return ServiceDetailsContentWithCategory(category: category!);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Text('No category data provided'),
      ),
    );
  }
}