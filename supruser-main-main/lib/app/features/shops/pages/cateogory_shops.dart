import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/features/shops/models/specific_shop_model.dart';
import 'package:suprapp/app/features/shops/pages/cart_page.dart';
import 'package:suprapp/app/features/shops/services/products_page.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_back_button.dart';

import '../../../core/constants/global_variables.dart';

class CateogoryShops extends StatefulWidget {
  final String categoryId;

  const CateogoryShops({super.key, required this.categoryId});

  @override
  State<CateogoryShops> createState() => _CateogoryShopsState();
}

class _CateogoryShopsState extends State<CateogoryShops> {
  Future<List<SpecificShopModel>> fetchSpecificShops(String id) async {
    context.loaderOverlay.show();

    final snapshot = await FirebaseFirestore.instance
        .collection('Shops')
        .doc(widget.categoryId)
        .collection('Spec Shops')
        .get();
    context.loaderOverlay.hide();
    return snapshot.docs.map((doc) {
      return SpecificShopModel.fromMap(doc.data());
    }).toList();
  }

  List<String> addressList = ["villa 13", "villa 14", "villa 15"];
  String selectedAddress = "villa 13";

  final List<String> recommendedSetOne = [
    AppImages.promotion,
    AppImages.promotion,
    AppImages.promotion,
  ];

  final List<String> recommendedSetTwo = [
    AppImages.po,
    AppImages.pt,
    AppImages.pth,
    AppImages.po,
    AppImages.pt,
    AppImages.pth,
  ];

  @override
  void initState() {
    super.initState();
    fetchSpecificShops(widget.categoryId);
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
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  //         border: Border.all(
                  //           color: Color(0xffB8B8B8),
                  //         )),
                  //     padding: EdgeInsets.all(5.0),
                  //     child: Icon(
                  //       Icons.arrow_back_ios_new,
                  //       size: 18,
                  //     ),
                  //   ),
                  // ),
                  CustomBackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Column(
                    // mainAxisSize: MainAxisSize.min,
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
                          Icon(Icons.location_on_outlined, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "Deliver to ",
                            style: textTheme(context)
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedAddress,
                              items: addressList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        textTheme(context).bodySmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedAddress = newValue!;
                                });
                              },
                              icon: Icon(Icons.keyboard_arrow_down_outlined,
                                  size: 20),
                              style: textTheme(context).bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                            ),
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
              SizedBox(
                height: 30.0,
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
              SizedBox(
                height: 20,
              ),
              Container(
                height: 265,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedSetOne.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 265,
                        width: 355,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: AssetImage(recommendedSetOne[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedSetTwo.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              image: AssetImage(recommendedSetTwo[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
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
                    "All Shops",
                    style: textTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              FutureBuilder<List<SpecificShopModel>>(
                future: fetchSpecificShops(widget.categoryId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());

                  if (snapshot.hasError)
                    return Center(child: Text('Error loading shops'));

                  if (!snapshot.hasData || snapshot.data!.isEmpty)
                    return Center(child: Text('No shops in this category'));

                  final shops = snapshot.data!;

                  return ListView.builder(
                    itemCount: shops.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final shop = shops[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductsPage(
                                  specId: shop.shopId,
                                  shopid: widget.categoryId,
                                ),
                              ),
                            );
                            // Navigator.pushNamed(
                            //     context, AppRoutes.shopsDetailsScreen);
                          },
                          contentPadding: EdgeInsets.zero,
                          isThreeLine: true,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              shop.shopImage,
                              height: 80.0,
                              width: 60.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Text(
                            shop.shopName,
                            style: textTheme(context)
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star,
                                      color: AppColors.darkGreen, size: 16),
                                  RichText(
                                    text: TextSpan(
                                      text: shop.rating,
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColors.darkGreen,
                                              fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: " (${shop.rating}) ",
                                          style: textTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text: ".${shop.arriveTime}",
                                          style: textTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: AppColors.darkGreen,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(AppIcon.happyIcon,
                                      width: 28, height: 18),
                                  SizedBox(width: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme(context).error,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 4.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: '40 ',
                                        style: textTheme(context)
                                            .labelMedium
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .onPrimary),
                                        children: [TextSpan(text: "% off")],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
