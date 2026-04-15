import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'Contact Us',
                      style: textTheme(context).bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme(context).surface),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Text(
                    "Supr",
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                  Text("  >  ", style: TextStyle(color: Colors.grey)),
                  Text(
                    "Submit a request",
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme(context).primary),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: textTheme(context).bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500, color: AppColors.darkGrey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.darkGrey,
                    size: 18,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "Contact Us",
                style: textTheme(context).displayLarge?.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.black87),
              ),

              const SizedBox(height: 20),

              // Email Field
              Text(
                "Your email address *",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Phone number *",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Please include country code",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme(context).primary),
              ),

              const SizedBox(height: 20),

              // Service Dropdown
              Text(
                "Service *",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: [
                  '-',
                  'Delivery',
                  'Ride',
                  'Payments',
                  'Shops',
                  'Other Services',
                  'Food',
                  'Supr Plus',
                  'Privacy Notice'
                ]
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: textTheme(context).bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),

              const SizedBox(height: 20),
              // Help Field
              Text(
                "What can we help you with? *",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: [
                  '-',
                  'Account Issue',
                  'App Feedback',
                  'Dispute',
                  'General Inquiry',
                  'Lost item',
                  'Other',
                ]
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: textTheme(context).bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Text(
                "Description*",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Please enter the details of your request . A member of our support staff will respond as soon as possible",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme(context).primary),
              ),
              const SizedBox(height: 20),
              Text(
                "Country*",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: [
                  '-',
                  'India',
                  'Iraq',
                  'Italy',
                  'Canada',
                  'Saudia Arabia',
                  'Dubai',
                ]
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: textTheme(context).bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Text(
                "Are you a Captain*",
                style: textTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: ['-', 'Yes', 'No']
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: textTheme(context).bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 40),
              CustomElevatedButton(
                text: 'Submit',
                onPressed: () {},
              ),
              // Text(
              //   'Hello, Arief!',
              //   style: textTheme(context).headlineSmall,
              // ),
              // const SizedBox(height: 8),
              // Text(
              //   'What can I help you for today?',
              //   style: textTheme(context).titleMedium,
              // ),
              // const SizedBox(height: 16),
              // CustomTextFormField(
              //     controller: controller, hint: "Search for help"),
              // const SizedBox(height: 12),
              // Text(
              //   'You can search some keywords from your problem for faster solution you might have.',
              //   style: textTheme(context)
              //       .bodyMedium
              //       ?.copyWith(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 24),
              // Text(
              //   'Frequently Asked',
              //   style: textTheme(context)
              //       .titleLarge
              //       ?.copyWith(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 16),
              // // FAQ cards
              // _buildFAQCard(
              //     'How do I create an account?',
              //     'You can create a Smartpay account by: download and open the smartpay application first then select ...',
              //     context),
              // const SizedBox(height: 16),
              // _buildFAQCard(
              //     'How to create a card for transactions?',
              //     'You can select the create card menu then select "Add New Card" select the continue button then you ...',
              //     context),
              // const SizedBox(height: 16),
              // _buildFAQCard(
              //     'How to Top Up on this App?',
              //     'Click the Top Up menu then select the amount of money and the method then click the "top up now" button...',
              //     context),
              // const SizedBox(height: 32),
              // SizedBox(
              //     width: double.infinity,
              //     height: 50,
              //     child: CustomElevatedButton(
              //         text: "Submit Appeal", onPressed: () {})),
              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQCard(
    String title,
    String content,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appGrey),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme(context)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: textTheme(context)
                .bodyLarge
                ?.copyWith(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}
