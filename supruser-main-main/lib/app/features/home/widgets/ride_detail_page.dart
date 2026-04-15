import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/home/widgets/ride_tile.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';

class RideDetailPage extends StatefulWidget {
  const RideDetailPage({super.key});

  @override
  State<RideDetailPage> createState() => _RideDetailPageState();
}

class _RideDetailPageState extends State<RideDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
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
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Ride to  Dubai   Mall",
                style: textTheme(context)
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Downtown   Dubai",
                style: textTheme(context)
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Dubai",
                style: textTheme(context)
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Cancelled",
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme(context).error),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "on Tuesday 10, June 2026 11:31 am",
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme(context).onSurface),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.headphones,
                  size: 20,
                  color: colorScheme(context).onSurface,
                ),
                label: Text(
                  'Get help with this ride',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorScheme(context).onSurface,
                    fontSize: 15,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize:
                      const Size(double.infinity, 59), // Full width, height 59
                  side: BorderSide(color: AppColors.appGrey), // Outline color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Payement Summary",
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ride Fare",
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.darkGrey),
                  ),
                  Text(
                    "INR 55",
                    style: textTheme(context).bodyMedium?.copyWith(
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: textTheme(context).titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface),
                  ),
                  Text(
                    "INR 55",
                    style: textTheme(context).titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Paid with",
                style: textTheme(context)
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.payment,
                    size: 20,
                    color: AppColors.darkGrey,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Cash",
                    style: textTheme(context).bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  minimumSize: const Size(double.infinity, 59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'A cancellation fee was charged',
                  style: TextStyle(
                    color: Colors.black, // Dark text for contrast
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Comfort Ride details",
                style: textTheme(context)
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.radio_button_checked,
                          color: Colors.purple),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      const Icon(Icons.location_on, color: Colors.purple),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tahir Qadri Abayat",
                            style: textTheme(context)
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text(
                          "Tahir Qadri Abayat, Tariq Road - PECHS Block 2 - Pakistan",
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        Text("Lahore DHA",
                            style: textTheme(context)
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text(
                          "62, 7 F St, D.H.A Phase 6 Defence Housing Authority",
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 10,
                shadowColor: AppColors.appGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Colors.grey[200],
                    height: 160,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg', // replace with Google Map or asset
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Your Captain",
                style: textTheme(context)
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,

                    backgroundImage: NetworkImage(
                        'https://toppng.com/uploads/preview/happy-black-person-115314937552vhdlzhqnj.png'), // Replace with actual image
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Islam K.",
                              style: textTheme(context)
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, color: Colors.blue, size: 16),
                          Text(" 4.9",
                              style: textTheme(context)
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 8, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text("White Lexus ES300H",
                              style: textTheme(context).bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkGrey)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text("L42132"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Need help with this rides",
                style: textTheme(context)
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Directly report your problem or visit the help center to find answers of your question",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.darkGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
