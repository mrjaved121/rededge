import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/auth/pages/biometric_setup_page.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Order confirmation",
          style: textTheme(context).titleMedium?.copyWith(
              color: colorScheme(context).onSurface,
              fontWeight: FontWeight.w700),
        ),
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.green[50],
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.flash_on, color: colorScheme(context).primary),
                    const SizedBox(width: 8),
                    Text(
                      "Delivery in 10 minutes",
                      style: textTheme(context).bodyLarge?.copyWith(
                          color: colorScheme(context).primary,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),

              // Order Items
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Item(s)",
                        style: textTheme(context).titleMedium?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),

                      // Dal Makhani Rice Bowl
                      Row(
                        children: [
                          const Icon(Icons.radio_button_checked,
                              color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dal Makhani Rice Bowl",
                                  style: textTheme(context).bodyLarge?.copyWith(
                                      color: colorScheme(context)
                                          .onSurface
                                          .withOpacity(0.4),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Thums Up Can, Coca Co...",
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context)
                                          .onSurface
                                          .withOpacity(0.3),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.remove, color: Colors.green),
                              SizedBox(width: 8),
                              Text("1"),
                              SizedBox(width: 8),
                              Icon(Icons.add, color: Colors.green),
                            ],
                          ),
                          const SizedBox(width: 8),
                          const Text("₹315",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.radio_button_checked,
                              color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pani Puri",
                                  style: textTheme(context).bodyLarge?.copyWith(
                                      color: colorScheme(context)
                                          .onSurface
                                          .withOpacity(0.4),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Thums Up Can, Coca Co...",
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context)
                                          .onSurface
                                          .withOpacity(0.3),
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.remove, color: Colors.green),
                              SizedBox(width: 8),
                              Text("1"),
                              SizedBox(width: 8),
                              Icon(Icons.add, color: Colors.green),
                            ],
                          ),
                          const SizedBox(width: 8),
                          const Text("₹203",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                              child: Text(
                            "Peri Peri Wedges",
                            style: textTheme(context).bodyLarge?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Remove",
                                style: textTheme(context).bodySmall?.copyWith(
                                    color: colorScheme(context).primary,
                                    fontWeight: FontWeight.w700),
                              )),
                          Text(
                            "Free",
                            style: textTheme(context).bodySmall?.copyWith(
                                color: colorScheme(context).primary,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Offers & Coupons
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Offers & Coupons",
                        style: textTheme(context).titleLarge?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.discount, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                              child: Text(
                            "TRYSWISHNEW\nSave upto ₹80 on this order",
                            style: textTheme(context).bodyMedium?.copyWith(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.5),
                                fontWeight: FontWeight.w700),
                          )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Remove",
                                style: textTheme(context).bodySmall?.copyWith(
                                    color: colorScheme(context).primary,
                                    fontWeight: FontWeight.w700),
                              )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {},
                        child: const Text("View more coupons >",
                            style: TextStyle(color: Colors.green)),
                      )
                    ],
                  ),
                ),
              ),

              // Billing Details
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Billing Details",
                        style: textTheme(context).titleLarge?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.2),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "₹608  ₹518",
                            style: textTheme(context).bodyLarge?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery",
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.2),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Free",
                            style: textTheme(context).bodyMedium?.copyWith(
                                color: colorScheme(context).primary,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount (TRYSWISHNEW)",
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.2),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "₹80",
                            style: textTheme(context).bodyMedium?.copyWith(
                                color: colorScheme(context).primary,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Bar
              Container(
                color: Colors.grey[100],
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer,
                            color: Color.fromARGB(255, 199, 158, 36)),
                        const SizedBox(width: 8),
                        Text(
                          "Service Unavailable",
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: colorScheme(context).secondary,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Change",
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: colorScheme(context).onSurface,
                                  fontWeight: FontWeight.w700),
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: Container(
                                    height: 270,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              context.pop();
                                            },
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                    AppColors.appGrey,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 18,
                                                    color: colorScheme(context)
                                                        .onSurface
                                                        .withOpacity(0.3),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Image.network(
                                              'https://static.vecteezy.com/system/resources/previews/009/343/548/non_2x/round-sticker-with-percent-color-icon-discount-offer-label-isolated-illustration-vector.jpg',
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              'TRYSWISHNEW applied ',
                                              style: textTheme(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: colorScheme(
                                                              context)
                                                          .onSurface
                                                          .withOpacity(0.4)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              '80 savings with this coupon',
                                              style: textTheme(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          colorScheme(context)
                                                              .onSurface),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              'Horray! Your coupon is sucessfully',
                                              style: textTheme(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: colorScheme(
                                                              context)
                                                          .onSurface
                                                          .withOpacity(0.4)),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              'applied',
                                              style: textTheme(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: colorScheme(
                                                              context)
                                                          .onSurface
                                                          .withOpacity(0.4)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  'Yay!',
                                                  style: textTheme(context)
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: colorScheme(
                                                                  context)
                                                              .primary),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          "Pay ₹460",
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: colorScheme(context).surface,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
