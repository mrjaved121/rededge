import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _isLoading = false;
  bool _isFormComplete = false;

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_checkFormComplete);
    _expiryDateController.addListener(_checkFormComplete);
    _cvvController.addListener(_checkFormComplete);
  }

  void _checkFormComplete() {
    final cardNumber = _cardNumberController.text.replaceAll(' ', '');
    final expiryDate = _expiryDateController.text;
    final cvv = _cvvController.text;

    setState(() {
      _isFormComplete = cardNumber.length >= 16 &&
          expiryDate.length == 5 &&
          cvv.length == 3;
    });
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Keyboard overflow fix
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Dimmed background overlay (tappable to close)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  color: Colors.black.withOpacity(0.3), // Dimmed like original
                ),
              ),
            ),

            // Add card sheet (same as Payment: top:60 to bottom:0)
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // REMOVED: Drag handle line (no more middle line at top)

                    // Header with back button and title (same style as Payment)
                    Container(
                      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Container(
                              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 6)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300, width: 1),
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.getBorderRadius(context, 10),
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                size: ResponsiveUtils.getIconSize(context, base: 18),
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                          Text(
                            'Add card',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.sp(context, 18),
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable form content (with keyboard padding fix)
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Dynamic keyboard padding
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card number
                              Text(
                                'Card number',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.sp(context, 16),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                              CustomTextFormField(
                                controller: _cardNumberController,
                                hint: '',
                                keyboardType: TextInputType.number,
                                fillColor: Colors.white,
                                borderColor: Colors.grey.shade300,
                                focusBorderColor: Colors.black87,
                                hintColor: Colors.grey.shade400,
                                borderRadius: ResponsiveUtils.getBorderRadius(context, 8),
                                maxLength: 19,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  _CardNumberFormatter(),
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter card number';
                                  }
                                  if (value.replaceAll(' ', '').length < 16) {
                                    return 'Invalid card number';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),

                              // Expiry date and CVV Row
                              Row(
                                children: [
                                  // Expiry Date
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Expiry date',
                                          style: TextStyle(
                                            fontSize: ResponsiveUtils.sp(context, 16),
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                                        CustomTextFormField(
                                          controller: _expiryDateController,
                                          hint: 'MM/YY',
                                          keyboardType: TextInputType.number,
                                          fillColor: Colors.white,
                                          borderColor: Colors.grey.shade300,
                                          focusBorderColor: Colors.black87,
                                          hintColor: Colors.grey.shade400,
                                          borderRadius: ResponsiveUtils.getBorderRadius(context, 8),
                                          maxLength: 5,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            _ExpiryDateFormatter(),
                                          ],
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Required';
                                            }
                                            if (value.length < 5) {
                                              return 'Invalid';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: ResponsiveUtils.getSpacing(context, 16)),

                                  // CVV
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CVV',
                                          style: TextStyle(
                                            fontSize: ResponsiveUtils.sp(context, 16),
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                                        CustomTextFormField(
                                          controller: _cvvController,
                                          hint: '',
                                          keyboardType: TextInputType.number,
                                          fillColor: Colors.white,
                                          borderColor: Colors.grey.shade300,
                                          focusBorderColor: Colors.black87,
                                          hintColor: Colors.grey.shade400,
                                          borderRadius: ResponsiveUtils.getBorderRadius(context, 8),
                                          maxLength: 3,
                                          obscureText: false,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Required';
                                            }
                                            if (value.length < 3) {
                                              return 'Invalid';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),

                              // Add card Nickname
                              Text(
                                'Add card Nickname (optional)',
                                style: TextStyle(
                                  fontSize: ResponsiveUtils.sp(context, 16),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                              CustomTextFormField(
                                controller: _nicknameController,
                                hint: 'Internet shopping',
                                keyboardType: TextInputType.text,
                                fillColor: Colors.white,
                                borderColor: Colors.grey.shade300,
                                focusBorderColor: Colors.black87,
                                hintColor: Colors.grey.shade400,
                                borderRadius: ResponsiveUtils.getBorderRadius(context, 8),
                              ),

                              SizedBox(height: ResponsiveUtils.getSpacing(context, 24)),

                              // Card Type Icons
                              Row(
                                children: [
                                  _buildCardTypeIcon('VISA', Colors.blue.shade900),
                                  SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                                  _buildCardTypeIcon('MC', Colors.red),
                                  SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                                  _buildCardTypeIcon('AMEX', Colors.blue.shade700),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Fixed Bottom Section with Button and Security Text (same as Payment)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            // Add card Button
                            SizedBox(
                              width: double.infinity,
                              height: ResponsiveUtils.getButtonHeight(context, base: 56),
                              child: ElevatedButton(
                                onPressed: (_isFormComplete && !_isLoading) ? _handleAddCard : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFormComplete
                                      ? AppColors.darkGreen
                                      : Colors.grey.shade300,
                                  foregroundColor: _isFormComplete
                                      ? AppColors.lightGreen
                                      : Colors.grey.shade600,
                                  disabledBackgroundColor: Colors.grey.shade300,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.getBorderRadius(context, 8),
                                    ),
                                  ),
                                ),
                                child: _isLoading
                                    ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _isFormComplete
                                          ? AppColors.lightGreen
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                )
                                    : Text(
                                  'Add card',
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.sp(context, 16),
                                    fontWeight: FontWeight.w500,
                                    color: _isFormComplete
                                        ? AppColors.lightGreen
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

                            // Security Text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shield_outlined,
                                  size: ResponsiveUtils.getIconSize(context, base: 18),
                                  color: Colors.black87,
                                ),
                                SizedBox(width: ResponsiveUtils.getSpacing(context, 6)),
                                Text(
                                  'All payment information is stored securely',
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.sp(context, 14),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddCard() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Card added successfully!'),
          backgroundColor: AppColors.appGreen,
        ),
      );

      context.pop();
    }
  }

  Widget _buildCardTypeIcon(String label, Color color) {
    return Container(
      width: ResponsiveUtils.adaptive(context, small: 50.0, medium: 55.0, large: 60.0),
      height: ResponsiveUtils.adaptive(context, small: 35.0, medium: 38.0, large: 40.0),
      padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 8)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getBorderRadius(context, 6),
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 12),
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}

// Card Number Formatter (unchanged)
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// Expiry Date Formatter (unchanged)
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length && i < 4; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}