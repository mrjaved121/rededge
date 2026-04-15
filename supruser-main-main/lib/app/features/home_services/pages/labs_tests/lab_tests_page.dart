import 'package:flutter/cupertino.dart';

import '../../mixservicesmainetailpage/servicedetailcontent.dart';

class LabTestsPage extends StatelessWidget {
  const LabTestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ServiceDetailsContent(
      categoryId: 'lab_tests',
    );
  }
}

