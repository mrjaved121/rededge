import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class CustomTitleContainer extends StatelessWidget {
  final String title;
  final String location;
  final String distance;
  final String rating;
  final String norating;
  const CustomTitleContainer(
      {super.key,
      required this.title,
      required this.location,
      required this.distance,
      required this.rating,
      required this.norating});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.12,
      width: width,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme(context)
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                location,
                style: textTheme(context).bodyMedium?.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Business Bay(${distance})",
                style: textTheme(context).bodySmall?.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          Card(
            child: Container(
              height: height * 0.1,
              width: width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: Color.fromARGB(255, 198, 196, 196)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star,
                            size: 15, color: colorScheme(context).primary),
                        Text(
                          rating,
                          style: textTheme(context).labelMedium?.copyWith(
                              color: colorScheme(context).primary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(norating,
                      style: textTheme(context).labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey)),
                  const SizedBox(height: 3),
                  Text("ratings",
                      style: textTheme(context).labelMedium?.copyWith(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
