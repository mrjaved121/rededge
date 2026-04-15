import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';


class OutstandingPaymentPage extends StatelessWidget {
  const OutstandingPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: ResponsiveUtils.getIconSize(context, base: 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Outstanding payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: ResponsiveUtils.adaptive(
              context,
              small: 17,
              medium: 18,
              large: 19,
              tablet: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Main Content - No scrolling
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount Section
                  Text(
                    'PKR 919.50',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 18,
                        medium: 20,
                        large: 22,
                        tablet: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                  Text(
                    'You have 1 outstanding transaction. Please pay soon to avoid service disruption',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w400,
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 13,
                        medium: 14,
                        large: 15,
                        tablet: 16,
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.hp(context, 4)),

                  // Summary Section
                  Text(
                    'SUMMARY',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 11,
                        medium: 12,
                        large: 13,
                        tablet: 14,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                  // Transport Transaction
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 12)
                      ),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: ResponsiveUtils.getSpacing(context, 18)
                          ),
                          child: Container(
                            width: ResponsiveUtils.getIconSize(context, base: 48),
                            height: ResponsiveUtils.getIconSize(context, base: 48),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.directions_car,
                              color: Colors.grey.shade700,
                              size: ResponsiveUtils.getIconSize(context, base: 24),
                            ),
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.getSpacing(context, 10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transport',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 14,
                                    medium: 15,
                                    large: 16,
                                    tablet: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),
                              Text(
                                'Monday - 27 Oct 10:56PM',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 12,
                                    medium: 13,
                                    large: 14,
                                    tablet: 15,
                                  ),
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),
                              Text(
                                'Transaction ID: 41774846',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 11,
                                    medium: 12,
                                    large: 13,
                                    tablet: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: ResponsiveUtils.getSpacing(context, 10)
                          ),
                          child: Text(
                            'PKR 919.50',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 14,
                                medium: 15,
                                large: 16,
                                tablet: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.hp(context, 3)),

                  // Total Section
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ResponsiveUtils.getSpacing(context, 16)
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade300,
                          width: ResponsiveUtils.adaptive(
                            context,
                            small: 1.2,
                            medium: 1.5,
                            large: 1.5,
                            tablet: 2.0,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total outstanding payment',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 15,
                              medium: 16,
                              large: 17,
                              tablet: 18,
                            ),
                          ),
                        ),
                        Text(
                          'PKR 919.50',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 15,
                              medium: 16,
                              large: 17,
                              tablet: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Spacer to push help text to bottom
                  const Spacer(),

                  // Help Link
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Something wrong? Get help.',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: ResponsiveUtils.adaptive(
                            context,
                            small: 13,
                            medium: 14,
                            large: 15,
                            tablet: 16,
                          ),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pay Button at Bottom
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: ResponsiveUtils.getButtonHeight(context, base: 50),
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        ResponsiveUtils.getBorderRadius(context, 25)
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Pay back now',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 15,
                      medium: 16,
                      large: 17,
                      tablet: 18,
                    ),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}