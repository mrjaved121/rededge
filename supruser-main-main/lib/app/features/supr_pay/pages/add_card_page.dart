import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';


class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nicknameController.text = 'Internet shopping';
  }

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
          'Add card',
          style: TextStyle(
            color: Colors.black,
            fontSize: ResponsiveUtils.adaptive(
              context,
              small: 18,
              medium: 20,
              large: 22,
              tablet: 24,
            ),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: ResponsiveUtils.responsivePadding(
                  context,
                  horizontal: 20,
                  vertical: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card number
                  Text(
                    'Card number',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 13,
                        medium: 14,
                        large: 15,
                        tablet: 16,
                      ),
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                  TextField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                        borderSide: const BorderSide(color: Color(0xFF00543C)),
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),

                  // Expiry and CVV
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expiry date',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                ),
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                            TextField(
                              controller: expiryController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'MM/YY',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFBDBDBD),
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 13,
                                    medium: 14,
                                    large: 15,
                                    tablet: 16,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  borderSide: const BorderSide(color: Color(0xFF00543C)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CVV',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 13,
                                  medium: 14,
                                  large: 15,
                                  tablet: 16,
                                ),
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                            TextField(
                              controller: cvvController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              maxLength: 3,
                              decoration: InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8)
                                  ),
                                  borderSide: const BorderSide(color: Color(0xFF00543C)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),

                  // Nickname
                  Text(
                    'Add card Nickname (optional)',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 13,
                        medium: 14,
                        large: 15,
                        tablet: 16,
                      ),
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                  TextField(
                    controller: nicknameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                        borderSide: const BorderSide(color: Color(0xFF00543C)),
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),

                  // Card logos
                  Row(
                    children: [
                      _buildCardLogo(context, 'VISA'),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                      _buildCardLogo(context, 'MC'),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                      _buildCardLogo(context, 'AMEX'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom section
          Container(
            padding: ResponsiveUtils.responsivePadding(
                context,
                horizontal: 20,
                vertical: 20
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: ResponsiveUtils.getButtonHeight(context, base: 56),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add card action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                      ),
                    ),
                    child: Text(
                      'Add card',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 16,
                          medium: 18,
                          large: 20,
                          tablet: 22,
                        ),
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: ResponsiveUtils.getIconSize(context, base: 16),
                      color: Colors.black54,
                    ),
                    SizedBox(width: ResponsiveUtils.getSpacing(context, 6)),
                    Text(
                      'All payment information is stored securely',
                      style: TextStyle(
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 11,
                          medium: 12,
                          large: 13,
                          tablet: 14,
                        ),
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardLogo(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 16),
        vertical: ResponsiveUtils.getSpacing(context, 10),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(
            ResponsiveUtils.getBorderRadius(context, 8)
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: ResponsiveUtils.adaptive(
            context,
            small: 13,
            medium: 14,
            large: 15,
            tablet: 16,
          ),
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nicknameController.dispose();
    super.dispose();
  }
}