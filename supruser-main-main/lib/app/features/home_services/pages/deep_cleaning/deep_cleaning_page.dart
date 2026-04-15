import 'package:flutter/cupertino.dart';

import '../../mixservicesmainetailpage/servicedetailcontent.dart';

class DeepCleaningPage extends StatelessWidget {
  const DeepCleaningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsContent(
      categoryId: 'deep_cleaning',
    );
  }
}

