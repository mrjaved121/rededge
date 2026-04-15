import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import '../../controller/electronics_controller.dart';
import '../category_card.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();

    // 🔹 Synchronize both scrolls manually
    _scrollController1.addListener(() {
      if (_scrollController2.hasClients &&
          _scrollController2.offset != _scrollController1.offset) {
        _scrollController2.jumpTo(_scrollController1.offset);
      }
    });

    _scrollController2.addListener(() {
      if (_scrollController1.hasClients &&
          _scrollController1.offset != _scrollController2.offset) {
        _scrollController1.jumpTo(_scrollController2.offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ElectronicsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(context, 4.3),
          ),
          child: Text(
            'Shop by category',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: ResponsiveUtils.hp(context, 1.5)),

        // 🔹 First horizontal list
        SizedBox(
          height: ResponsiveUtils.hp(context, 15.0),
          child: ListView.builder(
            controller: _scrollController1,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(context, 4.3),
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: controller.categories[index]);
            },
          ),
        ),

        SizedBox(height: ResponsiveUtils.hp(context, 0.0)),

        // 🔹 Second horizontal list (scrolls together with first)
        SizedBox(
          height: ResponsiveUtils.hp(context, 17.0),
          child: ListView.builder(
            controller: _scrollController2,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(context, 4.3),
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: controller.categories[index]);
            },
          ),
        ),
      ],
    );
  }
}