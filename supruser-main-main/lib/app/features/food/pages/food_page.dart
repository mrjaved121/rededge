// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/food/controller/food_controller.dart';
import 'package:suprapp/app/features/food/model/food_model.dart';
import 'package:suprapp/app/features/food/pages/catagory_detail_page.dart';
import 'package:suprapp/app/features/food/widgets/food_filter_widget.dart';
import 'package:suprapp/app/features/food/widgets/lists.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

import '../../../shared/widgets/custom_menu_button.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<String> addressList = ["Villa 13", "Villa 14", "Villa 15"];
  String selectedAddress = "Villa 13";
  final List<String> allFilters = [
    'Offers',
    'Top Rated',
    'Free Delivery',
  ];
  final List<String> imageList = [
    AppImages.banner1Image,
    AppImages.banner2Image,
    AppImages.banner3Image,
    AppImages.banner4Image,
  ];
  final List<String> inspiringList = [
    'https://img.freepik.com/free-photo/people-taking-photos-food_23-2149303524.jpg',
    'https://media.istockphoto.com/id/506828094/photo/waitress-taking-orders-to-people-at-a-restaurant.jpg?s=612x612&w=0&k=20&c=ppBNb3-qk0S8VprfTNmJLbHQIb5O4qgm7UiWw9cr_OI=',
    'https://media.istockphoto.com/id/1304752349/photo/female-customer-buying-food-on-digital-tablet-at-cashier-counter.jpg?s=170667a&w=is&k=20&c=QyFbRTExyAWvH5PWXk3jwg4kSgayEWI2-W9KOBqnw9s='
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final foodProvider = Provider.of<FoodController>(context);
    final foodList = foodProvider.foods;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(7)),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.darkGrey,
                size: 20,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Deliver to ",
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 3,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedAddress,
                items: addressList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedAddress = newValue!;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 20),
                style: textTheme(context).bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomMenuButton(
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
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: TopSheetWidget(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hint: '   Search for restaurents , dishes & cusines',
                      horizontalPadding: 8,
                      hintSize: 15,
                      hintColor: AppColors.darkGrey,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          AppIcon.searchIcon,
                          height: 10,
                          width: 10,
                          color: colorScheme(context).onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 1,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              toolbarHeight: 50,
              title: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Icons.filter_alt_outlined, size: 16),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: allFilters
                            .map((f) => FoodFilterButton(label: f))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: size.width * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(2, 4),
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(imageList[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "What are you craving today ",
                  style: textTheme(context)
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: (80 * 2) + 10, // 2 rows * 30 height + spacing
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1, // Square
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final item = categories[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CatagoryDetailPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['image']!,
                                  height: 45,
                                  width: 45,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  textAlign: TextAlign.center,
                                  item['text']!,
                                  style: textTheme(context)
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top trending restaurents",
                      style: textTheme(context)
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Discover the hottest spots in town",
                      style: textTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: size.height * 0.32,
                  width: size.width,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        final food = foodList[index];
                        return GestureDetector(
                            onTap: () {
                              foodProvider.selectFood(food);
                              context.pushNamed(AppRoute.foodDetail);
                            },
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Container(
                                height: size.height * 0.3,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: colorScheme(context).onPrimary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight:
                                                Radius.circular(5)),
                                            child: Image.network(
                                              food.image,
                                              height: size.height * 0.15,
                                              width: size.width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 70,
                                            left: 10,
                                            child: Text(
                                              "${index + 1}",
                                              style: textTheme(context)
                                                  .headlineLarge
                                                  ?.copyWith(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color:
                                                  colorScheme(context)
                                                      .onPrimary),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          food.title,
                                          style: textTheme(context)
                                              .bodyMedium
                                              ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme(context)
                                                  .onSurface),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          Icon(Icons.star,
                                              size: 15,
                                              color:
                                              colorScheme(context).primary),
                                          Text(
                                            food.rating,
                                            style: textTheme(context)
                                                .labelLarge
                                                ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme(context)
                                                    .primary),
                                          ),
                                          Container(
                                            height: 5,
                                            width: 5,
                                            margin: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle),
                                          ),
                                          Text(
                                            food.time,
                                            style: textTheme(context)
                                                .bodySmall
                                                ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme(context)
                                                    .onSurface),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const SizedBox(width: 8),
                                          SizedBox(
                                              width: 70,
                                              child: Text(food.location,
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: AppColors
                                                          .darkGrey))),
                                          Container(
                                            height: 5,
                                            width: 5,
                                            margin: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle),
                                          ),
                                          Text(food.distance,
                                              style: textTheme(context)
                                                  .labelLarge
                                                  ?.copyWith(
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color:
                                                  AppColors.darkGrey)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child: Text('50 % off just for items',
                                              style: textTheme(context)
                                                  .labelMedium
                                                  ?.copyWith(
                                                  fontSize: 10,
                                                  color:
                                                  colorScheme(context)
                                                      .surface,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                        ),
                                      )
                                    ]),
                              ),
                            ));
                      }),
                ),
                const SizedBox(height: 20),
                Text(
                  "Popular  Brands",
                  style: textTheme(context)
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.095,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularBrands.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final restaurent = popularBrands[index];
                      return InkWell(
                        onTap: () {
                          foodProvider.selectFood(restaurent);
                          context.pushNamed(AppRoute.foodDetail);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: size.height * 0.1,
                            width: size.width * 0.23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(restaurent.image),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Best Sellers 🔥",
                          style: textTheme(context)
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Satisfy cravings from top restaurents!",
                          style: textTheme(context).labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkGrey),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_outlined,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: size.height * 0.55,
                  width: size.width,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: bestSeller.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // This will ensure two rows of items
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio:
                      (size.width * 0.9 / 9) / (size.height * 0.2),
                    ),
                    scrollDirection:
                    Axis.horizontal, // Enables horizontal scrolling
                    itemBuilder: (context, index) {
                      final burger = bestSeller[index];

                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadowColor: const Color.fromARGB(255, 236, 239, 227),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              foodProvider.selectFood(burger);
                              context.pushNamed(AppRoute.foodDetail);
                            },
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                        child: Image.network(
                                          burger.image,
                                          height: size.height * 0.14,
                                          width: size.width * 0.25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Padding(
                                        padding: const EdgeInsets.all(.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              burger.title,
                                              style: textTheme(context)
                                                  .bodyMedium
                                                  ?.copyWith(
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color:
                                                  colorScheme(context)
                                                      .onSurface),
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: colorScheme(context)
                                                        .primary,
                                                    size: 14),
                                                const SizedBox(width: 4),
                                                Text(
                                                  burger.rating,
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: colorScheme(
                                                          context)
                                                          .primary),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  burger.time,
                                                  style: textTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: colorScheme(
                                                          context)
                                                          .onSurface),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              children: [
                                                Text(burger.location,
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: AppColors
                                                            .darkGrey)),
                                                const SizedBox(width: 8),
                                                Text(burger.distance,
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: AppColors
                                                            .darkGrey)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.pink,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                  ),
                                                  child: Text(
                                                      '50 % off just for items',
                                                      style: textTheme(context)
                                                          .labelMedium
                                                          ?.copyWith(
                                                          fontSize: 10,
                                                          color: colorScheme(
                                                              context)
                                                              .surface,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nearby  ⚡",
                          style: textTheme(context)
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Savor the speedy goodness!",
                          style: textTheme(context).labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkGrey),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_outlined,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: nearby.length,
                    itemBuilder: (context, index) {
                      final burger = nearby[index];
                      return InkWell(
                        onTap: () {
                          foodProvider.selectFood(burger);
                          context.pushNamed(AppRoute.foodDetail);
                        },
                        child: Container(
                          height: size.height * 0.3,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      burger.image,
                                      height: size.height * 0.15,
                                      width: size.width * 0.35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      burger.title,
                                      style: textTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme(context)
                                              .onSurface),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: colorScheme(context).primary,
                                            size: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          burger.rating,
                                          style: textTheme(context)
                                              .labelLarge
                                              ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme(context)
                                                  .primary),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          burger.time,
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme(context)
                                                  .onSurface),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Text(burger.location,
                                            style: textTheme(context)
                                                .labelLarge
                                                ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGrey)),
                                        const SizedBox(width: 8),
                                        Text(burger.distance,
                                            style: textTheme(context)
                                                .labelLarge
                                                ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGrey)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child: Text('50 % off just for items',
                                              style: textTheme(context)
                                                  .labelMedium
                                                  ?.copyWith(
                                                  color:
                                                  colorScheme(context)
                                                      .surface,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "All Restaurants",
                  style: textTheme(context)
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.7,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: nearby.length,
                    itemBuilder: (context, index) {
                      final burger = nearby[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadowColor: const Color.fromARGB(255, 236, 239, 227),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              foodProvider.selectFood(burger);
                              context.pushNamed(AppRoute.foodDetail);
                            },
                            child: Container(
                              height: size.height * 0.15,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                        child: Image.network(
                                          burger.image,
                                          height: size.height * 0.14,
                                          width: size.width * 0.25,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Padding(
                                        padding: const EdgeInsets.all(.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              burger.title,
                                              style: textTheme(context)
                                                  .bodyMedium
                                                  ?.copyWith(
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color:
                                                  colorScheme(context)
                                                      .onSurface),
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: colorScheme(context)
                                                        .primary,
                                                    size: 14),
                                                const SizedBox(width: 4),
                                                Text(
                                                  burger.rating,
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: colorScheme(
                                                          context)
                                                          .primary),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  burger.time,
                                                  style: textTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: colorScheme(
                                                          context)
                                                          .onSurface),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              children: [
                                                Text(burger.location,
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: AppColors
                                                            .darkGrey)),
                                                const SizedBox(width: 8),
                                                Text(burger.distance,
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: AppColors
                                                            .darkGrey)),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.pink,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                  ),
                                                  child: Text(
                                                      '50 % off just for items',
                                                      style: textTheme(context)
                                                          .labelMedium
                                                          ?.copyWith(
                                                          color: colorScheme(
                                                              context)
                                                              .surface,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// // ignore_for_file: deprecated_member_use
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:suprapp/app/core/constants/app_colors.dart';
// import 'package:suprapp/app/core/constants/app_images.dart';
// import 'package:suprapp/app/core/constants/global_variables.dart';
// import 'package:suprapp/app/features/food/controller/food_controller.dart';
// import 'package:suprapp/app/features/food/model/food_model.dart';
// import 'package:suprapp/app/features/food/pages/catagory_detail_page.dart';
// import 'package:suprapp/app/features/food/widgets/food_filter_widget.dart';
// import 'package:suprapp/app/features/food/widgets/lists.dart';
// import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
// import 'package:suprapp/app/routes/go_router.dart';
// import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';
//
// class FoodPage extends StatefulWidget {
//   const FoodPage({super.key});
//
//   @override
//   State<FoodPage> createState() => _FoodPageState();
// }
//
// class _FoodPageState extends State<FoodPage> {
//   List<String> addressList = ["Villa 13", "Villa 14", "Villa 15"];
//   String selectedAddress = "Villa 13";
//   final List<String> allFilters = [
//     'Offers',
//     'Top Rated',
//     'Free Delivery',
//   ];
//   final List<String> imageList = [
//     AppImages.banner1Image,
//     AppImages.banner2Image,
//     AppImages.banner3Image,
//     AppImages.banner4Image,
//   ];
//   final List<String> inspiringList = [
//     'https://img.freepik.com/free-photo/people-taking-photos-food_23-2149303524.jpg',
//     'https://media.istockphoto.com/id/506828094/photo/waitress-taking-orders-to-people-at-a-restaurant.jpg?s=612x612&w=0&k=20&c=ppBNb3-qk0S8VprfTNmJLbHQIb5O4qgm7UiWw9cr_OI=',
//     'https://media.istockphoto.com/id/1304752349/photo/female-customer-buying-food-on-digital-tablet-at-cashier-counter.jpg?s=170667a&w=is&k=20&c=QyFbRTExyAWvH5PWXk3jwg4kSgayEWI2-W9KOBqnw9s='
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     // final foodToggle = Provider.of<FoodToggleProvider>(context);
//     final foodProvider = Provider.of<FoodController>(context);
//     final foodList = foodProvider.foods;
//     return Scaffold(
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: () {
//               context.pop();
//             },
//             child: Container(
//               height: 30,
//               width: 30,
//               decoration: BoxDecoration(
//                   border: Border.all(color: AppColors.appGrey),
//                   borderRadius: BorderRadius.circular(7)),
//               child: const Icon(
//                 Icons.arrow_back,
//                 color: AppColors.darkGrey,
//                 size: 20,
//               ),
//             ),
//           ),
//         ),
//         centerTitle: true,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               "Deliver to ",
//               style: textTheme(context)
//                   .bodyLarge
//                   ?.copyWith(fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(
//               width: 3,
//             ),
//             DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 value: selectedAddress,
//                 items: addressList.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: textTheme(context).bodyLarge?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedAddress = newValue!;
//                   });
//                 },
//                 icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 20),
//                 style: textTheme(context).bodyLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//               onTap: () {
//                 showGeneralDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   barrierLabel: 'TopSheet',
//                   transitionDuration: const Duration(milliseconds: 300),
//                   pageBuilder: (_, __, ___) => const SizedBox.shrink(),
//                   transitionBuilder: (_, animation, __, ___) {
//                     return SlideTransition(
//                       position: Tween<Offset>(
//                         begin: const Offset(0, -1),
//                         end: Offset.zero,
//                       ).animate(animation),
//                       child: const Align(
//                         alignment: Alignment.topCenter,
//                         child: TopSheetWidget(),
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 height: 50,
//                 width: 40,
//                 decoration: BoxDecoration(
//                     color: colorScheme(context).primary,
//                     border: Border.all(color: AppColors.appGrey),
//                     borderRadius: BorderRadius.circular(7)),
//                 child: const Icon(
//                   Icons.menu,
//                   color: Color.fromARGB(255, 20, 188, 96),
//                   size: 15,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomTextFormField(
//                   hint: '   Search for restaurents , dishes & cusines',
//                   horizontalPadding: 8,
//                   hintSize: 15,
//                   hintColor: AppColors.darkGrey,
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: SvgPicture.asset(
//                       AppIcon.searchIcon,
//                       height: 10,
//                       width: 10,
//                       color: colorScheme(context).onSurface.withOpacity(0.6),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: Container(
//                         margin: const EdgeInsets.only(right: 8),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 7),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: const Icon(Icons.filter_alt_outlined, size: 16),
//                       ),
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: allFilters
//                               .map((f) => FoodFilterButton(label: f))
//                               .toList(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.25,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: imageList.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: const EdgeInsets.only(right: 12),
//                         width: size.width * 0.7,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.black.withOpacity(0.4),
//                               Colors.transparent
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.topRight,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.15),
//                               blurRadius: 6,
//                               offset: const Offset(2, 4),
//                             ),
//                           ],
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: AssetImage(imageList[index]),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "What are you craving today ",
//                   style: textTheme(context)
//                       .titleLarge
//                       ?.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                     height: (80 * 2) + 10, // 2 rows * 30 height + spacing
//                     child: GridView.builder(
//                       scrollDirection: Axis.horizontal,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 1, // Square
//                       ),
//                       itemCount: categories.length,
//                       itemBuilder: (context, index) {
//                         final item = categories[index];
//
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CatagoryDetailPage(),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             height: size.height * 0.1,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   item['image']!,
//                                   height: 45,
//                                   width: 45,
//                                   fit: BoxFit.contain,
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Text(
//                                   textAlign: TextAlign.center,
//                                   item['text']!,
//                                   style: textTheme(context)
//                                       .labelLarge
//                                       ?.copyWith(fontWeight: FontWeight.w600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     )),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Top trending restaurents",
//                       style: textTheme(context)
//                           .titleLarge
//                           ?.copyWith(fontWeight: FontWeight.w600),
//                     ),
//                     SizedBox(
//                       height: 2,
//                     ),
//                     Text(
//                       "Discover the hottest spots in town",
//                       style: textTheme(context).labelLarge?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.darkGrey),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.32,
//                   width: size.width,
//                   child: ListView.builder(
//                       padding: EdgeInsets.zero,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: foodList.length,
//                       itemBuilder: (context, index) {
//                         final food = foodList[index];
//                         return GestureDetector(
//                             onTap: () {
//                               foodProvider.selectFood(food);
//                               context.pushNamed(AppRoute.foodDetail);
//                             },
//                             child: Card(
//                               elevation: 6,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                               child: Container(
//                                 height: size.height * 0.3,
//                                 width: size.width * 0.4,
//                                 decoration: BoxDecoration(
//                                     color: colorScheme(context).onPrimary,
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                                 const BorderRadius.only(
//                                                     topLeft: Radius.circular(5),
//                                                     topRight:
//                                                         Radius.circular(5)),
//                                             child: Image.network(
//                                               food.image,
//                                               height: size.height * 0.15,
//                                               width: size.width,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                           Positioned(
//                                             top: 70,
//                                             left: 10,
//                                             child: Text(
//                                               "${index + 1}",
//                                               style: textTheme(context)
//                                                   .headlineLarge
//                                                   ?.copyWith(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color:
//                                                           colorScheme(context)
//                                                               .onPrimary),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           food.title,
//                                           style: textTheme(context)
//                                               .bodyMedium
//                                               ?.copyWith(
//                                                   fontWeight: FontWeight.w600,
//                                                   color: colorScheme(context)
//                                                       .onSurface),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           const SizedBox(width: 8),
//                                           Icon(Icons.star,
//                                               size: 15,
//                                               color:
//                                                   colorScheme(context).primary),
//                                           Text(
//                                             food.rating,
//                                             style: textTheme(context)
//                                                 .labelLarge
//                                                 ?.copyWith(
//                                                     fontWeight: FontWeight.w600,
//                                                     color: colorScheme(context)
//                                                         .primary),
//                                           ),
//                                           Container(
//                                             height: 5,
//                                             width: 5,
//                                             margin: const EdgeInsets.all(5),
//                                             decoration: const BoxDecoration(
//                                                 color: Colors.black,
//                                                 shape: BoxShape.circle),
//                                           ),
//                                           Text(
//                                             food.time,
//                                             style: textTheme(context)
//                                                 .bodySmall
//                                                 ?.copyWith(
//                                                     fontWeight: FontWeight.w600,
//                                                     color: colorScheme(context)
//                                                         .onSurface),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           const SizedBox(width: 8),
//                                           SizedBox(
//                                               width: 70,
//                                               child: Text(food.location,
//                                                   style: textTheme(context)
//                                                       .labelLarge
//                                                       ?.copyWith(
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           color: AppColors
//                                                               .darkGrey))),
//                                           Container(
//                                             height: 5,
//                                             width: 5,
//                                             margin: const EdgeInsets.all(5),
//                                             decoration: const BoxDecoration(
//                                                 color: Colors.black,
//                                                 shape: BoxShape.circle),
//                                           ),
//                                           Text(food.distance,
//                                               style: textTheme(context)
//                                                   .labelLarge
//                                                   ?.copyWith(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color:
//                                                           AppColors.darkGrey)),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Padding(
//                                         padding: const EdgeInsets.all(4.0),
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8, vertical: 3),
//                                           decoration: BoxDecoration(
//                                             color: Colors.pink,
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                           ),
//                                           child: Text('50 % off just for items',
//                                               style: textTheme(context)
//                                                   .labelMedium
//                                                   ?.copyWith(
//                                                       fontSize: 10,
//                                                       color:
//                                                           colorScheme(context)
//                                                               .surface,
//                                                       fontWeight:
//                                                           FontWeight.w600)),
//                                         ),
//                                       )
//                                     ]),
//                               ),
//                             ));
//                       }),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Popular  Brands",
//                   style: textTheme(context)
//                       .titleLarge
//                       ?.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.095,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: popularBrands.length,
//                     padding: EdgeInsets.zero,
//                     itemBuilder: (context, index) {
//                       final restaurent = popularBrands[index];
//                       return InkWell(
//                         onTap: () {
//                           foodProvider.selectFood(restaurent);
//                           context.pushNamed(AppRoute.foodDetail);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Container(
//                             height: size.height * 0.1,
//                             width: size.width * 0.23,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(restaurent.image),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Best Sellers 🔥",
//                           style: textTheme(context)
//                               .titleLarge
//                               ?.copyWith(fontWeight: FontWeight.w600),
//                         ),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         Text(
//                           "Satisfy cravings from top restaurents!",
//                           style: textTheme(context).labelLarge?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.darkGrey),
//                         ),
//                       ],
//                     ),
//                     Icon(
//                       Icons.arrow_forward_outlined,
//                       size: 20,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.55,
//                   width: size.width,
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     itemCount: bestSeller.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // This will ensure two rows of items
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 5,
//                       childAspectRatio:
//                           (size.width * 0.9 / 9) / (size.height * 0.2),
//                     ),
//                     scrollDirection:
//                         Axis.horizontal, // Enables horizontal scrolling
//                     itemBuilder: (context, index) {
//                       final burger = bestSeller[index];
//
//                       return Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         shadowColor: const Color.fromARGB(255, 236, 239, 227),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: InkWell(
//                             onTap: () {
//                               foodProvider.selectFood(burger);
//                               context.pushNamed(AppRoute.foodDetail);
//                             },
//                             child: Container(
//                               height: size.height * 0.2,
//                               width: size.width * 0.8,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(12),
//                                           bottomLeft: Radius.circular(12),
//                                         ),
//                                         child: Image.network(
//                                           burger.image,
//                                           height: size.height * 0.14,
//                                           width: size.width * 0.25,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               burger.title,
//                                               style: textTheme(context)
//                                                   .bodyMedium
//                                                   ?.copyWith(
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color:
//                                                           colorScheme(context)
//                                                               .onSurface),
//                                             ),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(Icons.star,
//                                                     color: colorScheme(context)
//                                                         .primary,
//                                                     size: 14),
//                                                 const SizedBox(width: 4),
//                                                 Text(
//                                                   burger.rating,
//                                                   style: textTheme(context)
//                                                       .labelLarge
//                                                       ?.copyWith(
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: colorScheme(
//                                                                   context)
//                                                               .primary),
//                                                 ),
//                                                 const SizedBox(width: 4),
//                                                 Text(
//                                                   burger.time,
//                                                   style: textTheme(context)
//                                                       .bodySmall
//                                                       ?.copyWith(
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: colorScheme(
//                                                                   context)
//                                                               .onSurface),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(burger.location,
//                                                     style: textTheme(context)
//                                                         .labelLarge
//                                                         ?.copyWith(
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             color: AppColors
//                                                                 .darkGrey)),
//                                                 const SizedBox(width: 8),
//                                                 Text(burger.distance,
//                                                     style: textTheme(context)
//                                                         .labelLarge
//                                                         ?.copyWith(
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             color: AppColors
//                                                                 .darkGrey)),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 10),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 8,
//                                                       vertical: 3),
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.pink,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                   child: Text(
//                                                       '50 % off just for items',
//                                                       style: textTheme(context)
//                                                           .labelMedium
//                                                           ?.copyWith(
//                                                               fontSize: 10,
//                                                               color: colorScheme(
//                                                                       context)
//                                                                   .surface,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600)),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 // Column(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Text(
//                 //       "Need inspiration",
//                 //       style: textTheme(context)
//                 //           .titleLarge
//                 //           ?.copyWith(fontWeight: FontWeight.w600),
//                 //     ),
//                 //     SizedBox(
//                 //       height: 2,
//                 //     ),
//                 //     Text(
//                 //       "Restaurents for every occasion",
//                 //       style: textTheme(context).labelLarge?.copyWith(
//                 //           fontWeight: FontWeight.w600,
//                 //           color: AppColors.darkGrey),
//                 //     ),
//                 //   ],
//                 // ),
//                 // SizedBox(
//                 //   height: 10,
//                 // ),
//                 // SizedBox(
//                 //   height: size.height * 0.25,
//                 //   child: ListView.builder(
//                 //     scrollDirection: Axis.horizontal,
//                 //     itemCount: inspiringList.length,
//                 //     padding: EdgeInsets.zero,
//                 //     itemBuilder: (context, index) {
//                 //       return Padding(
//                 //         padding: const EdgeInsets.all(8.0),
//                 //         child: Container(
//                 //           height: size.height * 0.15,
//                 //           width: size.width * 0.35,
//                 //           decoration: BoxDecoration(
//                 //             borderRadius: BorderRadius.circular(12),
//                 //             image: DecorationImage(
//                 //               fit: BoxFit.cover,
//                 //               image: NetworkImage(inspiringList[index]),
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       );
//                 //     },
//                 //   ),
//                 // ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Nearby  ⚡",
//                           style: textTheme(context)
//                               .titleLarge
//                               ?.copyWith(fontWeight: FontWeight.w600),
//                         ),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         Text(
//                           "Savor the speedy goodness!",
//                           style: textTheme(context).labelLarge?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.darkGrey),
//                         ),
//                       ],
//                     ),
//                     Icon(
//                       Icons.arrow_forward_outlined,
//                       size: 20,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   height: size.height * 0.3,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: nearby.length,
//                     itemBuilder: (context, index) {
//                       final burger = nearby[index];
//                       return InkWell(
//                         onTap: () {
//                           foodProvider.selectFood(burger);
//                           context.pushNamed(AppRoute.foodDetail);
//                         },
//                         child: Container(
//                           height: size.height * 0.3,
//                           width: size.width * 0.4,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(12),
//                                       topRight: Radius.circular(12),
//                                     ),
//                                     child: Image.network(
//                                       burger.image,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.35,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       burger.title,
//                                       style: textTheme(context)
//                                           .bodyMedium
//                                           ?.copyWith(
//                                               fontWeight: FontWeight.w600,
//                                               color: colorScheme(context)
//                                                   .onSurface),
//                                     ),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.star,
//                                             color: colorScheme(context).primary,
//                                             size: 14),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           burger.rating,
//                                           style: textTheme(context)
//                                               .labelLarge
//                                               ?.copyWith(
//                                                   fontWeight: FontWeight.w600,
//                                                   color: colorScheme(context)
//                                                       .primary),
//                                         ),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           burger.time,
//                                           style: textTheme(context)
//                                               .bodySmall
//                                               ?.copyWith(
//                                                   fontWeight: FontWeight.w600,
//                                                   color: colorScheme(context)
//                                                       .onSurface),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 2,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(burger.location,
//                                             style: textTheme(context)
//                                                 .labelLarge
//                                                 ?.copyWith(
//                                                     fontWeight: FontWeight.w500,
//                                                     color: AppColors.darkGrey)),
//                                         const SizedBox(width: 8),
//                                         Text(burger.distance,
//                                             style: textTheme(context)
//                                                 .labelLarge
//                                                 ?.copyWith(
//                                                     fontWeight: FontWeight.w500,
//                                                     color: AppColors.darkGrey)),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Row(
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8, vertical: 3),
//                                           decoration: BoxDecoration(
//                                             color: Colors.pink,
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                           ),
//                                           child: Text('50 % off just for items',
//                                               style: textTheme(context)
//                                                   .labelMedium
//                                                   ?.copyWith(
//                                                       color:
//                                                           colorScheme(context)
//                                                               .surface,
//                                                       fontWeight:
//                                                           FontWeight.w600)),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Text(
//                   "All Restaurants",
//                   style: textTheme(context)
//                       .titleLarge
//                       ?.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.7,
//                   child: ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: nearby.length,
//                     itemBuilder: (context, index) {
//                       final burger = nearby[index];
//                       return Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         shadowColor: const Color.fromARGB(255, 236, 239, 227),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: InkWell(
//                             onTap: () {
//                               foodProvider.selectFood(burger);
//                               context.pushNamed(AppRoute.foodDetail);
//                             },
//                             child: Container(
//                               height: size.height * 0.15,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(12),
//                                           bottomLeft: Radius.circular(12),
//                                         ),
//                                         child: Image.network(
//                                           burger.image,
//                                           height: size.height * 0.14,
//                                           width: size.width * 0.25,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(.0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               burger.title,
//                                               style: textTheme(context)
//                                                   .bodyMedium
//                                                   ?.copyWith(
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color:
//                                                           colorScheme(context)
//                                                               .onSurface),
//                                             ),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(Icons.star,
//                                                     color: colorScheme(context)
//                                                         .primary,
//                                                     size: 14),
//                                                 const SizedBox(width: 4),
//                                                 Text(
//                                                   burger.rating,
//                                                   style: textTheme(context)
//                                                       .labelLarge
//                                                       ?.copyWith(
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: colorScheme(
//                                                                   context)
//                                                               .primary),
//                                                 ),
//                                                 const SizedBox(width: 4),
//                                                 Text(
//                                                   burger.time,
//                                                   style: textTheme(context)
//                                                       .bodySmall
//                                                       ?.copyWith(
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: colorScheme(
//                                                                   context)
//                                                               .onSurface),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(burger.location,
//                                                     style: textTheme(context)
//                                                         .labelLarge
//                                                         ?.copyWith(
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             color: AppColors
//                                                                 .darkGrey)),
//                                                 const SizedBox(width: 8),
//                                                 Text(burger.distance,
//                                                     style: textTheme(context)
//                                                         .labelLarge
//                                                         ?.copyWith(
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                             color: AppColors
//                                                                 .darkGrey)),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 10),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 8,
//                                                       vertical: 3),
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.pink,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                   child: Text(
//                                                       '50 % off just for items',
//                                                       style: textTheme(context)
//                                                           .labelMedium
//                                                           ?.copyWith(
//                                                               color: colorScheme(
//                                                                       context)
//                                                                   .surface,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600)),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ]),
//         ),
//       ),
//     );
//   }
// }
