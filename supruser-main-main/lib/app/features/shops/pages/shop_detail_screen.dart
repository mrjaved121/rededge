import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/shops/pages/cart_page.dart';
import 'package:suprapp/app/shared/widgets/custom_back_button.dart';

class ShopDetailScreen extends StatefulWidget {
  final String specShopId;
  const ShopDetailScreen({super.key, required this.specShopId});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  List<String> addressList = ["villa 13", "villa 14", "villa 15"];
  String selectedAddress = "villa 13";

  final List<Map<String, String>> shopItems = [
    {"image": AppImages.pharmacy, "label": "Pharmacy"},
    {"image": AppImages.superMarket, "label": "Super Market"},
    {"image": AppImages.giftsFlowers, "label": "Gifts & Flowers"},
    {"image": AppImages.butchery, "label": "Butchery"},
    {"image": AppImages.petShops, "label": "Pet Shops"},
    {"image": AppImages.coffeeSweets, "label": "Coffee & Sweets"},
    {"image": AppImages.specialityGrocery, "label": "Speciality Grocery"},
    {"image": AppImages.moreShops, "label": "More Shops"},
    {"image": AppImages.moreShops, "label": "More Shops"},
  ];

  final List<String> recommendedSetOne = [
    AppImages.greeno,
    AppImages.greent,
    AppImages.greenth,
    AppImages.greeno,
    AppImages.greent,
    AppImages.greenth,
  ];

  final List<String> recommendedSetTwo = [
    AppImages.greeno,
    AppImages.greent,
    AppImages.greenth,
    AppImages.greeno,
    AppImages.greent,
    AppImages.greenth,
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Column(
                    children: [
                      Text(
                        "Shops",
                        style: textTheme(context).headlineLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreen),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.directions_bike, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "55-65 min deliver to",
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Container(
                  //   decoration: BoxDecoration(color: AppColors.darkGreen),
                  //   padding: EdgeInsets.all(5.0),
                  //   child: Icon(
                  //     Icons.menu,
                  //     color: colorScheme(context).onPrimary,
                  //     size: 18,
                  //   ),
                  // )
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CartPage(),
                      ));
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 30.0,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          border: Border(
                            top: BorderSide(color: Color(0xff9C9C9C)),
                            left: BorderSide(color: Color(0xff9C9C9C)),
                            right: BorderSide(color: Color(0xff9C9C9C)),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "AED ",
                                      style: textTheme(context).bodySmall,
                                      children: [
                                        TextSpan(
                                            text: "30",
                                            style: textTheme(context)
                                                .bodySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700)),
                                      ]),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Min Order",
                                  style: textTheme(context).bodySmall,
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: "AED ",
                                      style: textTheme(context).bodySmall,
                                      children: [
                                        TextSpan(
                                            text: "70",
                                            style: textTheme(context)
                                                .bodySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700)),
                                      ]),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Delivery",
                                  style: textTheme(context).bodySmall,
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Careem",
                                  style: textTheme(context)
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Delivery by",
                                  style: textTheme(context).bodySmall,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            ),
                            color: Color(0xffE9DFDF)),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcon.orderIcon),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Order above AED 50 for free delivery",
                              style: textTheme(context)
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search all shops and products",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(9.0),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xffBDBABA),
                    ),
                  ),
                  hintStyle: textTheme(context).titleMedium?.copyWith(
                        color: Color(0xff9C9C9C),
                      ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SvgPicture.asset(
                      AppIcon.searchIcon,
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(
                    maxHeight: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shop by Category",
                      style: textTheme(context).headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "All",
                          style: textTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    )
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 0.8,
                children: shopItems.map((item) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //     context, AppRoutes.categoryShopsScreen);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.stickerGrey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 5),
                          Image.asset(
                            item["image"]!,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            item["label"]!,
                            textAlign: TextAlign.center,
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Exotics",
                    style: textTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedSetOne.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, AppRoutes.productDetailsScreen);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 135,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                image: DecorationImage(
                                  image: AssetImage(recommendedSetTwo[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Coconut",
                                style: textTheme(context)
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              "₹ 30 / 135g",
                              style: textTheme(context).bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Exotics",
                    style: textTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedSetTwo.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, AppRoutes.productDetailsScreen);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 135,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                image: DecorationImage(
                                  image: AssetImage(recommendedSetTwo[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Coconut",
                                style: textTheme(context)
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              "₹ 30 / 135g",
                              style: textTheme(context).bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
