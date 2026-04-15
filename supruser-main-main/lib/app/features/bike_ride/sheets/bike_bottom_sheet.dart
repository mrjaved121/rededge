import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/bike_ride/model/bike_model.dart';
import 'package:suprapp/app/features/bike_ride/provider/bike_provider.dart';
import 'package:suprapp/app/features/bike_ride/sheets/bike_booking_sheet.dart';
import 'package:suprapp/app/features/bike_ride/sheets/select_time_sheet.dart';
import 'package:suprapp/app/features/rides/model/cars_model.dart';

import 'package:provider/provider.dart';
import 'package:suprapp/app/features/rides/provider/date_provider.dart';
import 'package:suprapp/app/features/rides/provider/selecting_car_provider.dart';
import 'package:suprapp/app/features/rides/widgets/selected_date.dart';
import 'package:suprapp/app/features/rides/widgets/show_booking_bottomSheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class BikeBottomSheet extends StatefulWidget {
  const BikeBottomSheet({super.key});

  @override
  State<BikeBottomSheet> createState() => _BikeBottomSheetState();
}

class _BikeBottomSheetState extends State<BikeBottomSheet> {
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();
  bool _dropdownSheetVisible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _dropdownSheetVisible = true;
        });
      }
    });

    _scrollController.addListener(() {
      final size = _scrollController.size;
      if (size >= 0.9 && _dropdownSheetVisible) {
        setState(() {
          _dropdownSheetVisible = false;
        });
      } else if (size <= 0.5 && !_dropdownSheetVisible) {
        setState(() {
          _dropdownSheetVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bikeProvider = Provider.of<BikeProvider>(context);

    return DraggableScrollableSheet(
      controller: _scrollController,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 1.0,
      expand: false,
      builder: (_, controller) => Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ride details",
                      style: textTheme(context)
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Consumer<PickupTimeProvider>(
                      builder: (context, provider, _) {
                        return GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (_) => const SelectTimeSheet(),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: colorScheme(context).primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  provider.selectedDay == null
                                      ? 'Select Pickup Time'
                                      : provider.displayTime,
                                  style: textTheme(context)
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: bike.length,
                    itemBuilder: (_, index) {
                      final bikess = bike[index];
                      return Card(
                        child: ListTile(
                          leading: Image.asset(bikess.image, width: 40),
                          title: Text(
                            bikess.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            bikess.subtitle,
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bikess.price,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                bikess.schdule,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          onTap: () => bikeProvider.selectBike(bikess),
                          selected: bikeProvider.selectedBike == bikess,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_dropdownSheetVisible)
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DropdownOptionsSheet(),
            ),
        ],
      ),
    );
  }
}

// ---------------------- Dropdown Options Sheet ------------------------

class DropdownOptionsSheet extends StatelessWidget {
  const DropdownOptionsSheet({super.key});

  void showCashSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (_) => const CashOptionsSheet(),
    );
  }

  void showDiscountSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevent dismissing
      builder: (_) => DiscountOptionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showCashSheet(context),
                  child: SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        const Icon(Icons.airplane_ticket_outlined,
                            color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(
                          "Cash",
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => showDiscountSheet(context),
                  child: SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcon.offer, height: 15, width: 15),
                        const SizedBox(width: 10),
                        Text(
                          "Discount",
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomElevatedButton(
                text: "Schedule ride",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const BikeBookingSheet(),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class CashOptionsSheet extends StatefulWidget {
  const CashOptionsSheet({super.key});

  @override
  CashOptionsSheetState createState() => CashOptionsSheetState();
}

class CashOptionsSheetState extends State<CashOptionsSheet> {
  bool switchValue = false;
  int radioValue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 20,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(2)),
            ),
            title: Text(
              "Cream pay",
              style: textTheme(context).bodySmall,
            ),
            subtitle: Text(
              "Use Credit first",
              style:
                  textTheme(context).labelLarge?.copyWith(color: Colors.grey),
            ),
            trailing: Transform.scale(
              scale: 0.7,
              child: Switch(
                value: switchValue,
                onChanged: (val) => setState(() => switchValue = val),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 20,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(2)),
            ),
            title: Text(
              "Cash",
              style: textTheme(context).bodySmall,
            ),
            trailing: Radio<int>(
              value: 1,
              groupValue: radioValue,
              onChanged: (val) => setState(() => radioValue = val!),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.bankpage);
              },
              child: Text(
                "+    ADD CARD",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).primary),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ---------------------- Discount Bottom Sheet ------------------------

class DiscountOptionsSheet extends StatefulWidget {
  const DiscountOptionsSheet({super.key});

  @override
  DiscountOptionsSheetState createState() => DiscountOptionsSheetState();
}

class DiscountOptionsSheetState extends State<DiscountOptionsSheet> {
  String? discountValue;

  @override
  void initState() {
    super.initState();
    // Delay opening to ensure the first build completes
    Future.delayed(Duration.zero, () => _showInnerDiscountSheet(context));
  }

  void _showInnerDiscountSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => InnerDiscountSheet(),
    );

    if (result != null) {
      setState(() {
        discountValue = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      child: discountValue == null
          ? Center(
              child: Text("No discount code entered.",
                  style: textTheme(context).bodyLarge))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Discount Code: $discountValue",
                      style: textTheme(context).bodyMedium),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const InnerDiscountSheet();
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, color: Colors.black, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            "Add New Promo",
                            style: textTheme(context)
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                      text: "Save",
                      onPressed: () {
                        context.pop();
                      })
                ],
              ),
            ),
    );
  }
}

class InnerDiscountSheet extends StatefulWidget {
  const InnerDiscountSheet({super.key});

  @override
  InnerDiscountSheetState createState() => InnerDiscountSheetState();
}

class InnerDiscountSheetState extends State<InnerDiscountSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Add Promo",
                  style: textTheme(context)
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  context.pop();
                  context.pop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.close, size: 15),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: _controller,
            borderRadius: 8,
            hint: "Enter Promo Code",
            hintColor: Colors.grey,
            focusBorderColor: Colors.grey.withOpacity(0.3),
          ),
          const SizedBox(height: 30),
          CustomElevatedButton(
              text: "Activate Code",
              onPressed: () {
                Navigator.pop(context, _controller.text);
              })
        ],
      ),
    );
  }
}
