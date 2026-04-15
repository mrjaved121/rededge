import 'package:flutter/cupertino.dart';

import '../../mixservicesmainetailpage/servicedetailcontent.dart';

class IvTherapyPage extends StatelessWidget {
  const IvTherapyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsContent(
      categoryId: 'iv_therapy',
    );
  }
}
