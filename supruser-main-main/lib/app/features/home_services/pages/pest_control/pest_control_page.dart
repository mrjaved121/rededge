import 'package:flutter/cupertino.dart';

import '../../mixservicesmainetailpage/servicedetailcontent.dart';

class PestControlPage extends StatelessWidget {
  const PestControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ServiceDetailsContent(
        categoryId: 'pest_control',
    );
  }
}
