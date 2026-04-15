import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/widgets/ride_detail_widget.dart';
import 'package:suprapp/app/routes/go_router.dart';

class DetailCancelRide extends StatefulWidget {
  const DetailCancelRide({super.key});

  @override
  State<DetailCancelRide> createState() => _DetailCancelRideState();
}

class _DetailCancelRideState extends State<DetailCancelRide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA-N8n4QH-jrKG204vwCEgaOj6-WMgt2dXUqPZ0oaiwFqcjWt25Kcm3GOUxBt9BrCJ3Bg&usqp=CAU",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Ride to Lahore DHA Defense Housing Authority - Karachi",
                style: textTheme(context)
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 16),
              child: RichText(
                  text: TextSpan(
                      text: "Cancelled ",
                      style: textTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.carmineRed),
                      children: [
                    TextSpan(
                      text: "on Tuesday, 20 May 2025 10:46 AM",
                      style: textTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    )
                  ])),
            ),
            const SizedBox(height: 10),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            customContainer(),
            const SizedBox(height: 10),
            Divider(
              color: Colors.black.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            RideDetailWidget(
              pickup: 'Tahir Qadri Abayat - Tariq Road - PECHS Block 2',
              dropoff:
                  'Lahore DHA - F Street - Defence Housing Authority - Karachi - Sindh',
            )
          ],
        ),
      ),
    );
  }

  Widget customContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: textTheme(context)
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ride fare",
                style:
                    textTheme(context).bodyLarge?.copyWith(color: Colors.grey),
              ),
              Text(
                "PKR 0",
                style:
                    textTheme(context).bodyLarge?.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "PKR 0",
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              context.pushNamed(AppRoute.yourRidePage);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "The fare for ride hase been waived",
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
