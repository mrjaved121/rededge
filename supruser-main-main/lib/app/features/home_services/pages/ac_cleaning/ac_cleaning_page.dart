import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../mixservicesmainetailpage/servicedetailcontent.dart';
import '../home_cleaning/provider/home_cleaing_provider.dart';

class AcCleaningPage extends StatefulWidget {
  const AcCleaningPage({super.key});

  @override
  State<AcCleaningPage> createState() => _AcCleaningPageState();
}

class _AcCleaningPageState extends State<AcCleaningPage> with RouteAware {
  @override
  void didPopNext() {
    final provider = Provider.of<BookingProvider>(context, listen: false);
    provider.loadCategory('ac_cleaning');
  }

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsContent(categoryId: 'ac_cleaning');
  }
}
