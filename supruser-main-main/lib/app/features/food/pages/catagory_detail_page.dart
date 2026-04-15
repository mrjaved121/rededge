import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/food/controller/food_controller.dart';
import 'package:suprapp/app/features/food/pages/sub_catagory_food.dart';
import 'package:suprapp/app/features/food/widgets/catagory_tab_buttons.dart';
import 'package:suprapp/app/features/food/widgets/food_filter_widget.dart';
import 'package:suprapp/app/features/food/widgets/lists.dart';
import 'package:suprapp/app/routes/go_router.dart';

class CatagoryDetailPage extends StatefulWidget {
  const CatagoryDetailPage({super.key});

  @override
  State<CatagoryDetailPage> createState() => _CatagoryDetailPageState();
}

class _CatagoryDetailPageState extends State<CatagoryDetailPage> {
  int selectedIndex = 0;
  final List<String> allFilters = [
    'GOT YOU',
    '4.5 + Rated',
    '30 mins',
    'Newly Added',
    'Group Order',
    'Top Choice',
    'Supr+ Exclusive',
    '30% Off',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final foodProvider = Provider.of<FoodController>(context);
    final foodList = foodProvider.foods;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Image.network(
                'https://www.foodandwine.com/thmb/DI29Houjc_ccAtFKly0BbVsusHc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/crispy-comte-cheesburgers-FT-RECIPE0921-6166c6552b7148e8a8561f7765ddf20b.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: colorScheme(context).surface,
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
              )
            ]),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                          allFilters.length,
                          (index) => CatagoryTabButtons(
                            label: allFilters[index],
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                        )),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "What's on your mind?",
                        style: textTheme(context)
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _foodCategory('Classic',
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0FoJ9skQZByTHEk3Qz8PF88o4Vjp1WrRMaw&s'),
                            _foodCategory('Smashed',
                                'https://static.vecteezy.com/system/resources/thumbnails/027/145/344/small_2x/delicious-bbq-bacon-burger-isolated-on-transparent-background-png.png'),
                            _foodCategory('Chicken Sando',
                                'https://static.vecteezy.com/system/resources/thumbnails/041/445/512/small_2x/ai-generated-delicious-chicken-sandwich-on-transparent-background-png.png'),
                            _foodCategory('Sliders',
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHzCC8dtX-YdqhUGPOkv6wet2JnokJtkGAUw&s'),
                            _foodCategory('Classic',
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0FoJ9skQZByTHEk3Qz8PF88o4Vjp1WrRMaw&s'),
                            _foodCategory('Smashed',
                                'https://static.vecteezy.com/system/resources/thumbnails/027/145/344/small_2x/delicious-bbq-bacon-burger-isolated-on-transparent-background-png.png'),
                            _foodCategory('Chicken Sando',
                                'https://static.vecteezy.com/system/resources/thumbnails/041/445/512/small_2x/ai-generated-delicious-chicken-sandwich-on-transparent-background-png.png'),
                            _foodCategory('Sliders',
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHzCC8dtX-YdqhUGPOkv6wet2JnokJtkGAUw&s'),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Top burgers 🍔',
                                style: textTheme(context)
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Meet your next burger obsession',
                                style: textTheme(context).bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.darkGrey),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: size.height * 0.32,
                        width: size.width,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: burgerList.length,
                            itemBuilder: (context, index) {
                              final food = burgerList[index];
                              return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Container(
                                      height: size.height * 0.3,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                          color: colorScheme(context).onPrimary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5)),
                                                  child: Image.network(
                                                    food['image'],
                                                    height: size.height * 0.15,
                                                    width: size.width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                food['title'],
                                                style: textTheme(context)
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            colorScheme(context)
                                                                .onSurface),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(width: 8),
                                                Icon(Icons.star,
                                                    size: 15,
                                                    color: colorScheme(context)
                                                        .primary),
                                                Text(
                                                  food['rating'].toString(),
                                                  style: textTheme(context)
                                                      .labelLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: colorScheme(
                                                                  context)
                                                              .primary),
                                                ),
                                                Container(
                                                  height: 5,
                                                  width: 5,
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.black,
                                                          shape:
                                                              BoxShape.circle),
                                                ),
                                                Text(
                                                  food['arriveTime'],
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
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                    width: 70,
                                                    child: Text(
                                                        food['foodItems'],
                                                        style: textTheme(
                                                                context)
                                                            .labelLarge
                                                            ?.copyWith(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .darkGrey))),
                                                Container(
                                                  height: 5,
                                                  width: 5,
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.black,
                                                          shape:
                                                              BoxShape.circle),
                                                ),
                                                Text(food['distance'],
                                                    style: textTheme(context)
                                                        .labelLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .darkGrey)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 8,
                                                ),
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
                                            )
                                          ]),
                                    ),
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Popular  Brands",
                        style: textTheme(context)
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: size.height * 0.08,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: brandsList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // context.pushNamed(AppRoute.foodDetail);
                              },
                              child: Container(
                                height: size.height * 0.08,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(brandsList[index]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '214 Burger Restaurents',
                        style: textTheme(context)
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: size.height * 0.7,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: burgerList.length,
                          itemBuilder: (context, index) {
                            final burger = burgerList[index];
                            return InkWell(
                              onTap: () {
                                context.pushNamed(AppRoute.foodDetail);
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadowColor:
                                    const Color.fromARGB(255, 236, 239, 227),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.15,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                              ),
                                              child: Image.network(
                                                burger['image'],
                                                height: size.height * 0.14,
                                                width: size.width * 0.25,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    burger['title'],
                                                    style: textTheme(context)
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: colorScheme(
                                                                    context)
                                                                .onSurface),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color: colorScheme(
                                                                  context)
                                                              .primary,
                                                          size: 14),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        burger['rating']
                                                            .toString(),
                                                        style: textTheme(
                                                                context)
                                                            .labelLarge
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: colorScheme(
                                                                        context)
                                                                    .primary),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        burger['arriveTime'],
                                                        style: textTheme(
                                                                context)
                                                            .bodySmall
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: colorScheme(
                                                                        context)
                                                                    .onSurface),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          burger['foodItems']
                                                              .toString(),
                                                          style: textTheme(
                                                                  context)
                                                              .labelLarge
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .darkGrey)),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                          burger['distance']
                                                              .toString(),
                                                          style: textTheme(
                                                                  context)
                                                              .labelLarge
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .darkGrey)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8,
                                                                vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.pink,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                            '50 % off just for items',
                                                            style: textTheme(
                                                                    context)
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
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _foodCategory(String label, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubCatagoryFoodPage(),
            ),
          );
        },
        child: Column(
          children: [
            Image.network(imagePath, height: 30),
            SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
