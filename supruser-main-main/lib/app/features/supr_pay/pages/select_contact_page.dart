
import 'package:flutter/material.dart';
import 'package:suprapp/app/features/supr_pay/pages/split_amount_page.dart';
import '../../../core/utils/responsive_utils.dart';


class SelectContactsPage extends StatefulWidget {
  final double amount;
  final String description;

  const SelectContactsPage({Key? key, required this.amount, required this.description}) : super(key: key);

  @override
  State<SelectContactsPage> createState() => _SelectContactsPageState();
}

class _SelectContactsPageState extends State<SelectContactsPage> {
  final List<Map<String, dynamic>> _allContacts = [
    {'name': 'john', 'phone': '+971061233118', 'initials': 'RA', 'amount': 0.0, 'isPaid': false},
    {'name': 'clark', 'phone': '+971472234233', 'initials': 'ER', 'amount': 0.0, 'isPaid': false},
    {'name': 'naeem', 'phone': '+971000089637', 'initials': 'AH', 'amount': 0.0, 'isPaid': false},
    {'name': '0300 4986448', 'phone': '+923004986448', 'initials': '03', 'amount': 0.0, 'isPaid': false},
    {'name': 'Ab', 'phone': '+971472234233', 'initials': 'AB', 'amount': 0.0, 'isPaid': false},
  ];

  final List<Map<String, dynamic>> _selectedContacts = [];

  @override
  void initState() {
    super.initState();
    // Always add "You" as selected by default but not in the contacts list
    _selectedContacts.add({
      'name': 'You',
      'phone': '',
      'initials': 'Y',
      'amount': 0.0,
      'isPaid': true
    });
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
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter a name or phone number',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: ResponsiveUtils.getIconSize(context, base: 20),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 8)
                  ),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.getSpacing(context, 12),
                  horizontal: ResponsiveUtils.getSpacing(context, 16),
                ),
                hintStyle: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 14,
                    medium: 15,
                    large: 16,
                    tablet: 17,
                  ),
                ),
              ),
              style: TextStyle(
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

          // Selected Contacts Section - Always visible with "You"
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.getSpacing(context, 16),
              vertical: ResponsiveUtils.getSpacing(context, 8),
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'SPLIT EXPENSE WITH',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 10,
                          medium: 11,
                          large: 12,
                          tablet: 13,
                        ),
                        fontWeight: FontWeight.w600
                    )
                ),
                SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                SizedBox(
                  height: ResponsiveUtils.hp(context, 9), // 9% of screen height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _selectedContacts[index];
                      final isYou = contact['phone'] == '';

                      return Container(
                        width: ResponsiveUtils.wp(context, 14), // 14% of screen width
                        margin: EdgeInsets.only(right: ResponsiveUtils.getSpacing(context, 8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: ResponsiveUtils.getIconSize(context, base: 22),
                                  backgroundColor: const Color(0xFFE8F5E9),
                                  child: Text(
                                    contact['initials'],
                                    style: TextStyle(
                                      color: const Color(0xFF34C759),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ResponsiveUtils.adaptive(
                                        context,
                                        small: 10,
                                        medium: 11,
                                        large: 12,
                                        tablet: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                // Only show close button for contacts that are not "You"
                                if (!isYou)
                                  Positioned(
                                    right: -ResponsiveUtils.getSpacing(context, 4),
                                    top: -ResponsiveUtils.getSpacing(context, 4),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedContacts.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 1)),
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                            Icons.close,
                                            size: ResponsiveUtils.getIconSize(context, base: 10),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),
                            Text(
                              contact['name'],
                              style: TextStyle(
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 8,
                                  medium: 9,
                                  large: 10,
                                  tablet: 11,
                                ),
                                fontWeight: FontWeight.w500,
                                height: 1.0,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ResponsiveUtils.getSpacing(context, 1)),

          // All Contacts List - "You" is NOT in this list
          Expanded(
            child: Container(
              color: const Color(0xFFF5F5F5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      ResponsiveUtils.getSpacing(context, 16),
                      ResponsiveUtils.getSpacing(context, 12),
                      ResponsiveUtils.getSpacing(context, 16),
                      ResponsiveUtils.getSpacing(context, 8),
                    ),
                    child: Text(
                        'ALL CONTACTS',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: ResponsiveUtils.adaptive(
                              context,
                              small: 10,
                              medium: 11,
                              large: 12,
                              tablet: 13,
                            ),
                            fontWeight: FontWeight.w600
                        )
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _allContacts.length,
                      itemBuilder: (context, index) {
                        final contact = _allContacts[index];
                        final isSelected = _selectedContacts.any((c) => c['phone'] == contact['phone']);

                        return Container(
                          margin: EdgeInsets.only(bottom: ResponsiveUtils.getSpacing(context, 0.5)),
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.getSpacing(context, 12),
                              vertical: ResponsiveUtils.getSpacing(context, 4),
                            ),
                            leading: CircleAvatar(
                              radius: ResponsiveUtils.getIconSize(context, base: 18),
                              backgroundColor: const Color(0xFFE8F5E9),
                              child: Text(
                                contact['initials'],
                                style: TextStyle(
                                  color: const Color(0xFF34C759),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveUtils.adaptive(
                                    context,
                                    small: 10,
                                    medium: 11,
                                    large: 12,
                                    tablet: 13,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              contact['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 12,
                                  medium: 13,
                                  large: 14,
                                  tablet: 15,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: contact['phone'].isNotEmpty ? Text(
                              contact['phone'],
                              style: TextStyle(
                                fontSize: ResponsiveUtils.adaptive(
                                  context,
                                  small: 10,
                                  medium: 11,
                                  large: 12,
                                  tablet: 13,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ) : null,
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedContacts.add(contact);
                                  } else {
                                    _selectedContacts.removeWhere((c) => c['phone'] == contact['phone']);
                                  }
                                });
                              },
                              activeColor: const Color(0xFF34C759),
                              side: BorderSide(
                                color: const Color(0xFFCCCCCC),
                                width: ResponsiveUtils.adaptive(
                                  context,
                                  small: 1.2,
                                  medium: 1.5,
                                  large: 1.5,
                                  tablet: 2.0,
                                ),
                              ),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            minLeadingWidth: ResponsiveUtils.wp(context, 8),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Continue Button - Always green and fixed at bottom
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 12)),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplitAmountPage(
                        amount: widget.amount,
                        description: widget.description,
                        selectedContacts: _selectedContacts,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34C759),
                  padding: EdgeInsets.symmetric(
                      vertical: ResponsiveUtils.getSpacing(context, 12)
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 35)
                      )
                  ),
                ),
                child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 13,
                          medium: 14,
                          large: 15,
                          tablet: 16,
                        ),
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}