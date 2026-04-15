import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class RideDetailWidget extends StatelessWidget {
  final String pickup;
  final String dropoff;

  const RideDetailWidget({
    super.key,
    required this.pickup,
    required this.dropoff,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "GO Premium ride details",
            style: textTheme(context)
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 1)),
                      child: const Icon(Icons.location_on_outlined,
                          color: Colors.blue)),
                  Container(
                    height: 35,
                    width: 2,
                    color: Colors.blue.shade200,
                  ),
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 2, 101, 181),
                          border: Border.all(
                              color: const Color.fromARGB(255, 2, 101, 181),
                              width: 1)),
                      child: const Icon(Icons.pin_drop_rounded,
                          color: Colors.white)),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pickup",
                        style: textTheme(context)
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      pickup,
                      style: textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Text("Drop-off",
                        style: textTheme(context)
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      dropoff,
                      style: textTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
                height: 200,
                child: Image.network(
                    'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg')),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.03),
          ),
          const SizedBox(height: 20),
          Text("Need help with this ride",
              style: textTheme(context)
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            "Directly report your problem or visit the help center to find answers to your questions.",
            style: textTheme(context).bodyMedium,
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.03),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.local_taxi_outlined),
                SizedBox(width: 12),
                Expanded(
                    child: Text(
                  "Visit rides help center",
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Divider(
            height: 1,
            color: Colors.black.withOpacity(0.03),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
