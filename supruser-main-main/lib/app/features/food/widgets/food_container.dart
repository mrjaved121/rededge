import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class FoodContainer extends StatelessWidget {
  final String time;
  final String price;
  final String fee;
  const FoodContainer(
      {super.key, required this.time, required this.fee, required this.price});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.08,
      width: width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 236, 232, 232)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "Delivery time",
                style: textTheme(context).labelLarge?.copyWith(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(time,
                  style: textTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).primary))
            ],
          ),
          Container(
            width: 1,
            color: Colors.black.withOpacity(0.3),
          ),
          Column(
            children: [
              Text(
                "Price For one",
                style: textTheme(context).labelLarge?.copyWith(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(price,
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
          Container(
            width: 1,
            color: Colors.black.withOpacity(0.3),
          ),
          Column(
            children: [
              Text(
                "Delivery Fee",
                style: textTheme(context).labelLarge?.copyWith(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(fee,
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
