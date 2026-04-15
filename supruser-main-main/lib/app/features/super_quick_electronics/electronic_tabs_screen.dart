import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/electronics_tab.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/gamming_tab.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/headset_tab.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/ipads_tab.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/laptop_tab.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/mobile_accessories.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/phome_tab.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/tablet_tab.dart';
import 'package:suprapp/app/features/super_quick_electronics/tabs/wire_charger_tab.dart';
import 'tabs/all_tab.dart';

class ElectronicTabScreen extends StatefulWidget {
  const ElectronicTabScreen({super.key});

  @override
  State<ElectronicTabScreen> createState() => _ElectronicTabScreenState();
}

class _ElectronicTabScreenState extends State<ElectronicTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'All',
    'Gaming',
    'iPads',
    'Headsets',
    'Electronics',
    'Phones',
    'Laptops',
    'Wires & Chargers',
    'Mobile accessories',
    'Tablets',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.close, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Best Sellers',
          style: TextStyle(
            color: Color(0xFF008F39), // Green color from the image
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.darkGreen,
              child: IconButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: 'TopSheet',
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                    transitionBuilder: (_, animation, __, ___) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: const TopSheetWidget(),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.menu,
                  size: 20,
                  color: colorScheme(context).surface,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              indicatorColor: const Color(0xFF008F39), // Green indicator color
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                AllTab(),
                GamingTab(),
                IPadsTab(),
                HeadsetsTab(),
                ElectronicsTab(),
                PhonesTab(),
                LaptopsTab(),
                WiresAndChargersTab(),
                MobileAccessoriesTab(),
                TabletsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
