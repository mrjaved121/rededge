import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/groceries/basket_screen.dart';
import 'package:suprapp/app/features/groceries/controllers/product_quantity_provider.dart';
import 'package:suprapp/app/features/groceries/controllers/tab_provider.dart';
import 'package:suprapp/app/features/groceries/widgets/add_basket.dart';
import 'package:suprapp/app/features/groceries/widgets/groceries_bottom_sheet.dart';
import 'package:suprapp/app/features/groceries/widgets/grocery_home_tabs.dart';
import 'package:suprapp/app/features/groceries/tabs/all_tab.dart';
import 'package:suprapp/app/features/groceries/widgets/select_address_sheet.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';

// ignore: must_be_immutable
class GroceriesHomeScreen extends StatelessWidget {
  GroceriesHomeScreen({super.key});

  final List<TabItem> tabItems = [
    TabItem(label: 'All', icon: Icons.apps),
    TabItem(label: 'Categories', icon: Icons.category),
    TabItem(label: 'Top Picks', icon: Icons.thumb_up),
    TabItem(label: 'All Deals', icon: Icons.local_offer),
    TabItem(label: 'Fresh', icon: Icons.eco),
  ];
  TextEditingController searchControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<TabProvider>().tabIndex;

    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 135,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: InkWell(
                  onTap: () => context.pop(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.appGrey),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                title: innerBoxIsScrolled
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: _buildCollapsedTitle(context),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'GROCERIES',
                            style: textTheme(context).headlineLarge?.copyWith(
                                  color: colorScheme(context).primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                centerTitle: true,
                actions: [
                  InkWell(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: 'TopSheet',
                        transitionDuration: Duration(milliseconds: 300),
                        pageBuilder: (_, __, ___) => SizedBox.shrink(),
                        transitionBuilder: (_, animation, __, ___) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0, -1),
                              end: Offset.zero,
                            ).animate(animation),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: TopSheetWidget(),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: colorScheme(context).primary,
                        border: Border.all(color: AppColors.appGrey),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(Icons.menu, color: Colors.green, size: 15),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(top: kToolbarHeight + 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20),
                          child: _buildCollapsedTitle(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchBarDelegate(),
              ),
            ];
          },
          body: Stack(
            children: [
              AllTab(),
              Consumer<QuantityProvider>(
                builder: (context, quantityProvider, child) {
                  return quantityProvider.basketedList.isEmpty
                      ? SizedBox()
                      : FloatingBasketButton(
                          totalAmout:
                              quantityProvider.totalAmount.toStringAsFixed(2),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BasketScreen()),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildCollapsedTitle(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const SelectAddressSheet(),
          );
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Mona',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: Colors.black54,
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              'Mona 63, Business Area',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
      const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Delivering in',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.flash_on_outlined, color: Colors.black, size: 18),
                SizedBox(width: 4),
                Text(
                  '18 mins',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ]),
    ]);
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 70;
  @override
  double get maxExtent => 70;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      alignment: Alignment.center,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search for groceries',
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
