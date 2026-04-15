import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/food/controller/food_controller.dart';
import 'package:suprapp/app/routes/go_router.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({super.key});

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final foodProvider = Provider.of<FoodController>(context);
    final foodList = foodProvider.foods;

    return Scaffold(
      appBar: AppBar(title: const Text('Food List')),
      body: SizedBox(
        height: height * 0.35,
        width: width,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              final food = foodList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      foodProvider.selectFood(food);
                      context.pushNamed(AppRoute.foodDetail);
                    },
                    child: Card(
                      child: Container(
                        height: height * 35,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            color: colorScheme(context).onPrimary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  child: Image.asset(
                                    food.image,
                                    height: height * 0.15,
                                    width: width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 70,
                                  left: 10,
                                  child: Text(
                                    "${index + 1}",
                                    style: textTheme(context)
                                        .titleLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                colorScheme(context).onPrimary),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                food.title,
                                style: textTheme(context).labelLarge?.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 8),
                                Icon(Icons.star,
                                    size: 15,
                                    color: colorScheme(context).primary),
                                Text(food.rating,
                                    style: textTheme(context)
                                        .labelMedium
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).primary)),
                                Container(
                                  height: 5,
                                  width: 5,
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                Text(food.time,
                                    style: textTheme(context).labelMedium)
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
                                          .labelMedium
                                          ?.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black
                                                  .withOpacity(0.4))),
                                ),
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
                                        .labelMedium
                                        ?.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            color:
                                                Colors.black.withOpacity(0.4)))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.carmineRed),
                                child: Text(
                                  food.discount,
                                  style: textTheme(context)
                                      .labelMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
