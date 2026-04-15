import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suprapp/app/features/supr_pay/pages/select_contact_page.dart';
import '../../../core/utils/responsive_utils.dart';





class SplitNewExpensePage extends StatefulWidget {
  const SplitNewExpensePage({Key? key}) : super(key: key);

  @override
  State<SplitNewExpensePage> createState() => _SplitNewExpensePageState();
}

class _SplitNewExpensePageState extends State<SplitNewExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _errorMessage = '';
  Color _nextButtonColor = const Color(0xFFCCCCCC);

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_updateButtonColor);
    _descriptionController.addListener(_updateButtonColor);
  }

  void _updateButtonColor() {
    setState(() {
      final hasValidAmount = _amountController.text.isNotEmpty &&
          double.tryParse(_amountController.text) != null;
      final hasDescription = _descriptionController.text.isNotEmpty;

      _nextButtonColor = (hasValidAmount && hasDescription)
          ? const Color(0xFF34C759)
          : const Color(0xFFCCCCCC);
    });
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateButtonColor);
    _descriptionController.removeListener(_updateButtonColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
          'Split new expense',
          style: TextStyle(
              color: Colors.black,
              fontSize: ResponsiveUtils.adaptive(
                context,
                small: 18,
                medium: 20,
                large: 22,
                tablet: 24,
              ),
              fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 8)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color(0xFF34C759),
                    width: ResponsiveUtils.adaptive(
                      context,
                      small: 1.5,
                      medium: 2,
                      large: 2,
                      tablet: 2.5,
                    )
                ),
              ),
              child: Text(
                  '?',
                  style: TextStyle(
                    color: const Color(0xFF34C759),
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.adaptive(
                      context,
                      small: 12,
                      medium: 14,
                      large: 16,
                      tablet: 18,
                    ),
                  )
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: ResponsiveUtils.responsivePadding(
                  context,
                  horizontal: 16,
                  vertical: 16
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ResponsiveUtils.hp(context, 4)),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 12)
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.getSpacing(context, 16),
                          horizontal: ResponsiveUtils.wp(context, 6),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 12)
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total amount to split',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 13,
                                    medium: 14,
                                    large: 15,
                                    tablet: 16,
                                  ),
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ResponsiveUtils.wp(context, 10)
                                  ),
                                  child: Text(
                                    'AED ',
                                    style: TextStyle(
                                        fontSize: ResponsiveUtils.adaptive(
                                          context,
                                          small: 24,
                                          medium: 26,
                                          large: 28,
                                          tablet: 30,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF5A6C7D)
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: ResponsiveUtils.wp(context, 25),
                                  child: TextField(
                                    controller: _amountController,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    style: TextStyle(
                                        fontSize: ResponsiveUtils.adaptive(
                                          context,
                                          small: 24,
                                          medium: 26,
                                          large: 28,
                                          tablet: 30,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF5A6C7D)
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        fontSize: ResponsiveUtils.adaptive(
                                          context,
                                          small: 24,
                                          medium: 26,
                                          large: 28,
                                          tablet: 30,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF5A6C7D),
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          bottom: ResponsiveUtils.getSpacing(context, 5)
                                      ),
                                    ),
                                    textAlign: TextAlign.left,
                                    onChanged: (value) {
                                      setState(() {
                                        _errorMessage = '';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),
                            Divider(
                              height: 1,
                              thickness: ResponsiveUtils.adaptive(
                                context,
                                small: 0.1,
                                medium: 0.2,
                                large: 0.2,
                                tablet: 0.3,
                              ),
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                            Container(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _descriptionController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add a text to tell your friends\nwhat they\'re paying you back for',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ResponsiveUtils.adaptive(
                                        context,
                                        small: 13,
                                        medium: 14,
                                        large: 15,
                                        tablet: 16,
                                      ),
                                      fontWeight: FontWeight.bold
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 13,
                                    medium: 14,
                                    large: 15,
                                    tablet: 16,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _errorMessage = '';
                                  });
                                },
                              ),
                            ),
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: ResponsiveUtils.getSpacing(context, 12)),
                                child: Text(
                                  _errorMessage,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: ResponsiveUtils.adaptive(
                                        context,
                                        small: 11,
                                        medium: 12,
                                        large: 13,
                                        tablet: 14,
                                      ),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: ResponsiveUtils.responsivePadding(
                context,
                horizontal: 16,
                vertical: 16
            ),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFE8F5E9),
                      padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.getSpacing(context, 14)
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 35)
                          )
                      ),
                    ),
                    child: Text(
                      'Import an existing Careem expense',
                      style: TextStyle(
                          color: const Color(0xFF34C759),
                          fontSize: ResponsiveUtils.adaptive(
                            context,
                            small: 13,
                            medium: 14,
                            large: 15,
                            tablet: 16,
                          ),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_descriptionController.text.isEmpty) {
                        setState(() {
                          _errorMessage = 'An expense description is required';
                        });
                      } else if (_amountController.text.isEmpty || double.tryParse(_amountController.text) == null) {
                        setState(() {
                          _errorMessage = 'Please enter a valid amount';
                        });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectContactsPage(
                              amount: double.parse(_amountController.text),
                              description: _descriptionController.text,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _nextButtonColor,
                      padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.getSpacing(context, 14)
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ResponsiveUtils.getBorderRadius(context, 35)
                          )
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: ResponsiveUtils.adaptive(
                            context,
                            small: 13,
                            medium: 14,
                            large: 15,
                            tablet: 16,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}