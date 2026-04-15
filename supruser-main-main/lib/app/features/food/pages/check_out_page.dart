import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/food/controller/cart_controller.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class PaymentMethodSheet extends StatefulWidget {
  @override
  _PaymentMethodSheetState createState() => _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends State<PaymentMethodSheet> {
  String selectedMethod = 'Cash';

  Widget buildPaymentOption({
    required IconData icon,
    required String title,
    String? subtitle,
    required String value,
    bool enabled = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: enabled ? Colors.black : Colors.grey),
      title: Text(
        title,
        style: textTheme(context).bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: enabled ? Colors.black : Colors.grey),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: textTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: Colors.black45),
            )
          : null,
      trailing: Radio<String>(
        value: value,
        groupValue: selectedMethod,
        onChanged: enabled
            ? (val) {
                setState(() {
                  selectedMethod = val!;
                });
              }
            : null,
      ),
      enabled: enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Text(
              "Select payment method",
              style: textTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).onSurface),
            ),
            SizedBox(height: 16),
            Divider(
              thickness: 1,
              color: AppColors.appGrey,
            ),
            buildPaymentOption(
              icon: Icons.account_balance_wallet,
              title: 'Careem credit',
              subtitle: 'Balance: PKR 0',
              value: 'Credit',
              enabled: false,
            ),
            buildPaymentOption(
              icon: Icons.money,
              title: 'Cash',
              value: 'Cash',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cards',
                  style: textTheme(context).bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextButton.icon(
                  onPressed: () {
                    context.pushNamed(AppRoute.addBankPage);
                  },
                  icon: Icon(
                    Icons.add,
                    color: colorScheme(context).onSurface,
                  ),
                  label: Text(
                    "Add",
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: AppColors.appGrey,
            ),
            ListTile(
              leading: Icon(Icons.credit_card, color: Colors.grey),
              title: Text(
                'Enjoy instant access to services and seamless balance top-ups!',
                style: textTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomElevatedButton(
                  text: 'Confirm',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool isChecked = false;
  void showNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.close, size: 28),
                    SizedBox(width: 12),
                    Text(
                      'Add a note to the restaurant',
                      style: textTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).onSurface),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'The restaurant will try its best to follow your request. Please note that once added, requests can not be removed after the order is placed.',
                  style: textTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme(context).onSurface.withOpacity(0.7)),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    maxLength: 150,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      hintText: "E.g. ‘I am allergic to nuts’",
                      counterText: "0/150",
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAddNoteToCaptainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.close, size: 28),
                    SizedBox(width: 12),
                    Text(
                      'Add a note to the captain',
                      style: textTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).onSurface),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Make your captain\'s job easier by letting them\nknow anything that will help them to deliever your\norder',
                  style: textTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme(context).onSurface.withOpacity(0.7)),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    maxLength: 150,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      hintText: "E.g. ‘please be aware of the dog’",
                      counterText: "0/150",
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (_) {
        return PaymentMethodSheet();
      },
    );
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        actionsPadding: const EdgeInsets.only(bottom: 16),
        title: Text(
          'An error occurred.',
          style: textTheme(context).headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme(context).onSurface),
        ),
        content: Text(
          'Something went wrong... Please try again.',
          style: textTheme(context).bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme(context).onSurface.withOpacity(0.6)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomElevatedButton(
              text: 'Ok',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              height: 30,
              width: 30,
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
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "McDonald's - Bay Avenue",
              style: textTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).onSurface),
            ),
            Text(
              "Business Bay",
              style: textTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.darkGrey),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: AppColors.appGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Your basket",
                    style: textTheme(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add,
                            size: 17, color: colorScheme(context).primary),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add more items",
                            style: textTheme(context).bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.appGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYvpxs1E5I-UMLMKnb74-Sr1NB7EVHXSOmvg&s',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  "Chicken McNuggets",
                  style: textTheme(context).bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).onSurface),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "AED 17",
                      style: textTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).onSurface),
                    ),
                    const SizedBox(height: 7),
                    Container(
                        height: 30,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.appGrey)),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 15,
                                color: colorScheme(context).onSurface,
                              ),
                              onPressed: cart.decreaseItem,
                            ),
                            Text(
                              "${cart.itemCount}",
                              style: textTheme(context).bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context).onSurface),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 15,
                                color: colorScheme(context).onSurface,
                              ),
                              onPressed: cart.increaseItem,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            const Divider(
              color: AppColors.appGrey,
            ),
            ListTile(
              leading: Icon(
                Icons.bookmark_outline,
                color: AppColors.darkGrey,
              ),
              title: Text(
                "Add a note to the restaurant",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface.withOpacity(0.6)),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colorScheme(context).onSurface.withOpacity(0.6),
              ),
              onTap: () {
                showNoteBottomSheet(context);
              },
            ),
            const Divider(
              color: AppColors.appGrey,
            ),
            ListTile(
              leading: const Icon(
                Icons.restaurant_outlined,
                color: AppColors.darkGrey,
              ),
              title: Text("Don't send cutlery",
                  style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface.withOpacity(0.6),
                      )),
              subtitle: Text(
                  "Help protect the environment with one simple choice",
                  style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme(context).onSurface.withOpacity(0.6),
                      )),
              trailing: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(
                  color: AppColors.appGrey,
                ),
                checkColor: Colors.white, // Tick color
                activeColor:
                    colorScheme(context).primary, // Fill color when checked
              ),
            ),
            const Divider(
              color: AppColors.appGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Tap to save",
                style: textTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.offers,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FAB25",
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.pink),
                        ),
                        Text(
                          "25% on select FAB an...",
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGrey.withOpacity(0.5)),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(children: [
                      Icon(Icons.add,
                          size: 17, color: colorScheme(context).primary),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Apply",
                          style: textTheme(context).bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).primary),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Have a code? Type it here",
                  hintStyle: textTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const Divider(
              color: AppColors.appGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Reward your Captain",
                    style: textTheme(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  const Icon(Icons.info_outline, size: 25)
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  rewardBox("3 AED"),
                  rewardBox("5 AED", isPopular: true),
                  rewardBox("10 AED"),
                  rewardBox("15 AED"),
                  rewardBox("10 AED"),
                  rewardBox("15 AED"),
                ],
              ),
            ),
            const Divider(
              color: AppColors.appGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Payment summary',
                style: textTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface),
              ),
            ),
            summaryRow('Basket total (incl. tax)', 'AED 17.00'),
            summaryRow('Service fee', 'AED 0.95', showInfo: true),
            summaryRow('Small order fee', 'AED 3.00', showInfo: true),
            summaryRow('Delivery fee', 'AED 6.50', showInfo: true),
            SizedBox(height: 8),
            summaryRow('Order Total (incl. tax)', 'AED 27.45', isBold: true),
            SizedBox(height: 10),
            const Divider(
              color: AppColors.appGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Delivery instruction',
                style: textTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  deliveryOption(Icons.call_end, 'Avoid calling'),
                  deliveryOption(Icons.notifications_off_outlined,
                      'Avoid ringing\nthe doorbell'),
                  deliveryOption(
                      Icons.door_back_door_outlined, 'Leave at the\ndoor',
                      disabled: true),
                  deliveryOption(Icons.person_outline, 'Leave with\nsecurity'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.delivery_dining,
                color: AppColors.darkGrey,
              ),
              title: Text(
                "Add a note to the captain",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).onSurface.withOpacity(0.6)),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colorScheme(context).onSurface.withOpacity(0.6),
              ),
              onTap: () {
                showAddNoteToCaptainBottomSheet(context);
              },
            ),
            const Divider(
              color: AppColors.appGrey,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 150,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.delivery_dining),
              title: Text("Deliver to Mona",
                  style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface,
                      )),
              subtitle: Text("67, 4, Business Bay, Dubai",
                  style: textTheme(context).bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme(context).onSurface.withOpacity(0.6),
                      )),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.darkGrey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {


                    //  i  am adding my cutom to check how it looks
                    final result = await context.pushNamed(AppRoute.paymentOptions);
                    if (result != null) {
                      // Handle the selected payment method
                      print("Selected payment method: $result");
                    }
                    // showPaymentMethodBottomSheet(context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.money),
                      const SizedBox(width: 8),
                      Text("Pay by ...",
                          style: textTheme(context).bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).onSurface,
                              )),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  height: 50,
                  width: 200,
                  text: 'Pay AED 12..',
                  onPressed: () {
                    showErrorDialog(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rewardBox(String text, {bool isPopular = false}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.darkGrey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child:
                    Text(text, style: TextStyle(fontWeight: FontWeight.bold))),
          ),
        ),
        if (isPopular)
          Positioned(
            top: -8,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("Popular",
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
      ],
    );
  }

  Widget summaryRow(String label, String value,
      {bool showInfo = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  label,
                  style: textTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).onSurface),
                ),
                if (showInfo)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child:
                        Icon(Icons.info_outline, size: 16, color: Colors.grey),
                  ),
              ],
            ),
          ),
          Text(
            value,
            style: textTheme(context).bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme(context).onSurface),
          ),
        ],
      ),
    );
  }

  Widget deliveryOption(IconData icon, String label, {bool disabled = false}) {
    return Opacity(
      opacity: disabled ? 0.3 : 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 130,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon, size: 24, color: AppColors.darkGrey.withOpacity(0.6)),
              SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: textTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme(context).onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
