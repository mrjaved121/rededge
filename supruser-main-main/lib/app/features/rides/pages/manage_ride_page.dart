import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

import 'package:suprapp/app/features/rides/widgets/arrow_back_leading.dart';
import 'package:suprapp/app/features/rides/widgets/cancel_custom_bottom_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';

class ManageRidePage extends StatefulWidget {
  const ManageRidePage({super.key});

  @override
  State<ManageRidePage> createState() => _ManageRidePageState();
}

class _ManageRidePageState extends State<ManageRidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomLeading(
          onTap: () {
            context.pop();
          },
        ),
        title: Text(
          "12 Jun, 1:20 AM - 1:30 AM",
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg', // replace with Google Map or asset
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 16),
              Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(width: 10),
              Text(
                "Cash",
                style: textTheme(context)
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            color: Colors.black.withOpacity(0.3),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.withOpacity(0.4),
              child: const Icon(Icons.person),
            ),
            title: Text(
              "Go premium",
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Details will appear here once a Caption is \nassigned",
              style:
                  textTheme(context).bodyMedium?.copyWith(color: Colors.grey),
            ),
          ),
          Divider(
            color: Colors.black.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "Call Support",
              style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => const CancelConfirmationBottomSheet(),
                );
              },
              child: Text(
                "Cancel Ride",
                style: textTheme(context).bodyLarge?.copyWith(
                    color: AppColors.carmineRed, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
