import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/dine_out/widgets/customTabController.dart';

class CustomContainer extends StatefulWidget {
  final List<String> images;
  final String text;
  final String title;
  final String rating;
  final String location;
  final String food;
  final String discount;
  const CustomContainer(
      {super.key,
      required this.images,
      required this.text,
      required this.title,
      required this.rating,
      required this.location,
      required this.food,
      required this.discount});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.images.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  children: [
                    TabBarView(
                      controller: tabController,
                      children: widget.images.map((imgPath) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            height: 200,
                            width: double.infinity,
                            imgPath,
                            cacheHeight: 150,
                            cacheWidth: 500,
                            fit: BoxFit.fill,
                          ),
                        );
                      }).toList(),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTabPageSelector(
                          controller: tabController,
                          selectedColor: Colors.white,
                          unselectedColor: Colors.grey,
                          width: 10,
                          height: 5,
                          borderRadius: 6,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 98, 229, 11),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(widget.text,
                              style: textTheme(context).labelMedium),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: isFavorite
                                    ? AppColors.appGreen
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite_border
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.white
                                    : AppColors.darkGrey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.title,
                  style: textTheme(context).titleLarge?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.star,
                      color: AppColors.chromeYellow, size: 16),
                  Text(
                    widget.rating,
                    style: textTheme(context)
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        color: colorScheme(context).onSurface,
                        shape: BoxShape.circle),
                  ),
                  Text(widget.location,
                      style: textTheme(context).bodyLarge?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.food,
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                decoration: BoxDecoration(
                    color: colorScheme(context).primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "😏+ | ${widget.discount}",
                  style: textTheme(context)
                      .labelLarge
                      ?.copyWith(color: AppColors.brightGreen),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
