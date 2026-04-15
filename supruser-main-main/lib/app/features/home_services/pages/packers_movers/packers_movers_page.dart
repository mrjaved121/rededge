import 'package:flutter/cupertino.dart';

import '../../mixservicesmainetailpage/servicedetailcontent.dart';

class PackersMoversPage extends StatelessWidget {
  const PackersMoversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ServiceDetailsContent(
        categoryId: 'packers_movers',
    );
  }
}

