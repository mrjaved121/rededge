// ==================== SERVICE PAGE - FIXED ====================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/customappbar.dart';

import 'collection_delivet_page.dart';
import 'laundaryordermodel.dart';

class LaundryServicePage extends StatefulWidget {
  final String serviceType;

  const LaundryServicePage({Key? key, required this.serviceType}) : super(key: key);

  @override
  State<LaundryServicePage> createState() => _LaundryServicePageState();
}

class _LaundryServicePageState extends State<LaundryServicePage> {
  late String selectedService;
  Map<String, int> selectedItems = {};
  int bedBathQty = 0;
  int washFoldQty = 0; // For 40°C service
  Map<String, bool> expandedCategories = {
    'Tops': true,
    'Bottoms': false,
    'Undergarment': false,
    'Home Items (Linens)': false,
    'Formal': false,
    'Others': false,
  };

  @override
  void initState() {
    super.initState();
    selectedService = widget.serviceType;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Laundry",showBackButton: true,),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildServiceIcons(context, width),
                SizedBox(height: height * 0.018),
                _buildServiceContent(context, width, height),
                SizedBox(height: height * 0.135), // Space for bottom bar
              ],
            ),
          ),
          _buildBottomBar(context, width),
        ],
      ),
    );
  }
  Widget _buildServiceIcons(BuildContext context, double width) {
    final services = [
      {'id': 'hanger', 'icon': '👔', 'name': 'Hang', 'color': const Color(0xFF00FF00)},
      {'id': 'iron', 'icon': '🔥', 'name': 'Iron', 'color': Colors.grey.shade300},
      {'id': 'pillow', 'icon': '🛏️', 'name': 'Pillow', 'color': const Color(0xFFFF4081)},
      {'id': 'temp', 'icon': '🌡️', 'name': '40°C', 'color': const Color(0xFF00BCD4)},
      {'id': 'shoe', 'icon': '👟', 'name': 'Shoe', 'color': const Color(0xFFFF6F00)},
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: width * 0.027, horizontal: width * 0.036),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: services.map((service) {
          final isSelected = selectedService == service['id'];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedService = service['id'] as String;

                // ✅ RESET selectedCareType when changing main service
                if (service['id'] == 'shoe') {
                  selectedCareType = ''; // Reset to empty when shoe icon is clicked
                }
              });
            },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.150,
                    height: width * 0.150,
                    padding: isSelected ? EdgeInsets.all(4) : EdgeInsets.zero, // Space for gap
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                        color: AppColors.lightGreen, // Your app color
                        width: 2.0,
                      )
                          : null,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: (service['color'] as Color).withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          service['icon'] as String,
                          style: TextStyle(fontSize: width * 0.054),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          );
        }).toList(),
      ),
    );
  }
  Widget _buildServiceContent(BuildContext context, double width, double height) {
    // Route to different content based on selected service
    switch (selectedService) {
      case 'pillow':
        return _buildBedBathContent(context, width, height);
      case 'temp':
        return _buildWashFoldContent(context, width, height);
      case 'shoe':
      // Show ShoeCare or BagCare based on selectedCareType
        return _buildShoeBagSelector(context, width, height);
      case 'hanger':
      case 'iron':
      default:
        return _buildItemListContent(context, width, height);
    }
  }

// NEW WIDGET: Shoe/Bag Selector
  Widget _buildShoeBagSelector(BuildContext context, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.036),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Selection Buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCareType = 'shoe';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: width * 0.036),
                    decoration: BoxDecoration(
                      color: selectedCareType == 'shoe'
                          ? Colors.white
                          : Colors.white,
                      border: Border.all(
                        color: selectedCareType == 'shoe'
                            ? const Color(0xFFFF6F00)
                            : Colors.grey.shade300,
                        width: selectedCareType == 'shoe' ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('👟', style: TextStyle(fontSize: width * 0.045)),
                        SizedBox(width: width * 0.018),
                        Text(
                          'ShoeCare',
                          style: TextStyle(
                            fontSize: width * 0.036,
                            fontWeight: FontWeight.w700,
                            color: selectedCareType == 'shoe'
                                ? const Color(0xFFFF6F00)
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: width * 0.027),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCareType = 'bag';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: width * 0.036),
                    decoration: BoxDecoration(
                      color: selectedCareType == 'bag'
                          ? const Color(0xFFFF6F00)
                          : Colors.white,
                      border: Border.all(
                        color: selectedCareType == 'bag'
                            ? const Color(0xFFFF6F00)
                            : Colors.grey.shade300,
                        width: selectedCareType == 'bag' ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('👜', style: TextStyle(fontSize: width * 0.045)),
                        SizedBox(width: width * 0.018),
                        Text(
                          'BagCare',
                          style: TextStyle(
                            fontSize: width * 0.036,
                            fontWeight: FontWeight.w700,
                            color: selectedCareType == 'bag'
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.027),

          // Show content based on selection OR blank if nothing selected
          if (selectedCareType == 'shoe')
            _buildShoeContentOnly(context, width, height)
          else if (selectedCareType == 'bag')
            _buildBagContentOnly(context, width, height)
          else
            _buildEmptySelectionContent(context, width, height), // Blank content
        ],
      ),
    );
  }

  Widget _buildEmptySelectionContent(BuildContext context, double width, double height) {
    return Container(

      padding: EdgeInsets.all(width * 0.09),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.09),
          Text(
            '',
            style: TextStyle(fontSize: width * 0.18),
          ),
          SizedBox(height: height * 0.027),
          Text(
            '',
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: width * 0.018),
          Text(
            '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width * 0.029,
              color: Colors.grey.shade500,
              height: 1.4,
            ),
          ),
          SizedBox(height: height * 0.09),
        ],
      ),
    );
  }

  // Widget _buildServiceContent(BuildContext context, double width, double height) {
  //   // Route to different content based on selected service
  //   switch (selectedService) {
  //     case 'pillow':
  //       return _buildBedBathContent(context, width, height);
  //     case 'temp':
  //       return _buildWashFoldContent(context, width, height);
  //     case 'shoe':
  //       return _buildShoeContent(context, width, height);
  //     case 'hanger':
  //     case 'iron':
  //     default:
  //       return _buildItemListContent(context, width, height);
  //   }
  // }

  Widget _buildItemListContent(BuildContext context, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.036),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.036),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sending your items',
                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: width * 0.018),
                Text(
                  'Use the Orange Sticker to send your items. Items will be delivered after 7-14 days.',
                  style: TextStyle(
                    fontSize: width * 0.027,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.027),
          Text(
            'Pricing',
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1B5E20),
            ),
          ),
          SizedBox(height: width * 0.018),
          Text(
            'Each item is charged separately',
            style: TextStyle(
              fontSize: width * 0.027,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: height * 0.018),
          Text(
            'Price exclusive of VAT',
            style: TextStyle(
              fontSize: width * 0.024,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: height * 0.027),
          ...expandedCategories.keys.map((category) {
            return _buildCategorySection(context, width, height, category);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, double width, double height, String category) {
    final isExpanded = expandedCategories[category] ?? false;
    final items = _getItemsForCategory(category);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedCategories[category] = !isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: width * 0.027),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 0.9),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: const Color(0xFF1B5E20),
                  size: width * 0.054,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          ...items.map((item) {
            final itemKey = '${item['id']}_${selectedService}';
            final quantity = selectedItems[itemKey] ?? 0;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: width * 0.027),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] as String,
                          style: TextStyle(
                            fontSize: width * 0.032,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: width * 0.009),
                        Text(
                          'AED ${item['price']}',
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1B5E20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  quantity == 0
                      ? GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItems[itemKey] = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.036,
                        vertical: width * 0.018,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: width * 0.029,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00E676),
                        ),
                      ),
                    ),
                  )
                      : Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.018,
                      vertical: width * 0.009,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676).withOpacity(0.2),
                      border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (quantity > 1) {
                                selectedItems[itemKey] = quantity - 1;
                              } else {
                                selectedItems.remove(itemKey);
                              }
                            });
                          },
                          child: Icon(
                            Icons.remove,
                            size: width * 0.041,
                            color: const Color(0xFF00E676),
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: width * 0.032,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF00E676),
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedItems[itemKey] = quantity + 1;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            size: width * 0.041,
                            color: const Color(0xFF00E676),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }

  // NEW: Wash & Fold Content for 40°C service
  Widget _buildWashFoldContent(BuildContext context, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.036),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Section
          Container(
            width: double.infinity,
            height: height * 0.225,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFB2EBF2), Color(0xFF00BCD4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.8),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: height * 0.027,
                  left: width * 0.045,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wash & Fold',
                        style: TextStyle(
                          fontSize: width * 0.054,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF006064),
                        ),
                      ),
                      SizedBox(height: width * 0.018),
                      Text(
                        'Perfect for your\ncasual and sport wear',
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: const Color(0xFF006064),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: width * 0.027),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.027,
                          vertical: width * 0.018,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF006064),
                          borderRadius: BorderRadius.circular(13.5),
                        ),
                        child: Text(
                          'up to 12 kg\'s',
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: width * 0.036,
                  bottom: height * 0.018,
                  child: Container(
                    padding: EdgeInsets.all(width * 0.036),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '🌡️',
                      style: TextStyle(fontSize: width * 0.108),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.027),
          // Description
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: width * 0.029,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
              children: [
                TextSpan(text: 'Fill the bag with any item that is '),
                TextSpan(
                  text: 'suitable for 40°C wash and tumble dry.',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: ' Pressing not included'),
              ],
            ),
          ),
          SizedBox(height: height * 0.036),
          // Pricing Section
          Text(
            'Pricing',
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1B5E20),
            ),
          ),
          SizedBox(height: height * 0.027),
          Container(
            padding: EdgeInsets.all(width * 0.036),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(10.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'AED 75',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Text(
                          'AED 55 per bag*',
                          style: TextStyle(
                            fontSize: width * 0.036,
                            fontWeight: FontWeight.w900,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                washFoldQty == 0
                    ? GestureDetector(
                  onTap: () {
                    setState(() {
                      washFoldQty = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.036,
                      vertical: width * 0.018,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: width * 0.029,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00E676),
                      ),
                    ),
                  ),
                )
                    : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.018,
                    vertical: width * 0.009,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676).withOpacity(0.2),
                    border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (washFoldQty > 0) {
                            setState(() => washFoldQty--);
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: width * 0.041,
                          color: const Color(0xFF00E676),
                        ),
                      ),
                      SizedBox(width: width * 0.027),
                      Text(
                        washFoldQty.toString(),
                        style: TextStyle(
                          fontSize: width * 0.036,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF00E676),
                        ),
                      ),
                      SizedBox(width: width * 0.027),
                      GestureDetector(
                        onTap: () {
                          setState(() => washFoldQty++);
                        },
                        child: Icon(
                          Icons.add,
                          size: width * 0.041,
                          color: const Color(0xFF00E676),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.018),
          Text(
            '*This bag could hold up to 12 Kg\'s laundry, equal to 3 full laundry loads at home. Each bag is charged at AED 75.00 AED 55.00',
            style: TextStyle(
              fontSize: width * 0.024,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          SizedBox(height: width * 0.018),
          Text(
            'Price exclusive of VAT',
            style: TextStyle(
              fontSize: width * 0.024,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: height * 0.036),
          // Items perfect for section
          Text(
            'Items perfect for',
            style: TextStyle(
              fontSize: width * 0.036,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF006064),
            ),
          ),
          SizedBox(height: height * 0.027),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPerfectForItem(context, width, '👕', 'Casual\nwear'),
              _buildPerfectForItem(context, width, '🏠', 'Home\nwear'),
              _buildPerfectForItem(context, width, '🏃', 'Active\nwear'),
              _buildPerfectForItem(context, width, '🩲', 'Under-\ngarments'),
              _buildPerfectForItem(context, width, '➕', 'And\nmore'),
            ],
          ),
          SizedBox(height: height * 0.027),
        ],
      ),
    );
  }

  Widget _buildPerfectForItem(BuildContext context, double width, String icon, String label) {
    return Column(
      children: [
        Container(
          width: width * 0.135,
          height: width * 0.135,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(10.8),
          ),
          child: Center(
            child: Text(
              icon,
              style: TextStyle(fontSize: width * 0.054),
            ),
          ),
        ),
        SizedBox(height: width * 0.018),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: width * 0.024,
            color: Colors.grey.shade700,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  // Placeholder for Shoe service
  // ==================== REQUIRED VARIABLES ====================
// Add these variables at the top of your State class:

  String selectedCareType = ''; // 'shoe' or 'bag'
  Map<String, int> shoeItems = {};
  Map<String, int> bagItems = {};
  Map<String, bool> expandedAddons = {};
  Map<String, bool> expandedBagAddons = {};
  Widget _buildShoeContentOnly(BuildContext context, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sending Info
        Text(
          'Sending your shoes',
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B5E20),
          ),
        ),
        SizedBox(height: height * 0.018),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: width * 0.029,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
            children: [
              TextSpan(text: 'Use the '),
              TextSpan(
                text: 'Orange Sticker',
                style: TextStyle(
                  color: const Color(0xFFFF6F00),
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: ' to send your shoes.\n'),
              TextSpan(text: 'Shoe polishing will need '),
              TextSpan(
                text: '2 days',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: '\nShoe cleaning will need '),
              TextSpan(
                text: '4 days',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: '.\nColour restoration & repair services will need '),
              TextSpan(
                text: '4-10 days',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: '.'),
            ],
          ),
        ),
        SizedBox(height: width * 0.018),
        Text(
          'We will contact you to confirm a precise delivery date and time',
          style: TextStyle(
            fontSize: width * 0.027,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
        SizedBox(height: height * 0.036),

        // Basic Cleaning Package
        Container(
          padding: EdgeInsets.all(width * 0.036),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cleaning_services, color: const Color(0xFF1B5E20), size: width * 0.045),
                  SizedBox(width: width * 0.018),
                  Text(
                    'Pricing: Basic Cleaning Package',
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.018),
              Text(
                'Our basic package includes:',
                style: TextStyle(
                  fontSize: width * 0.029,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: width * 0.018),
              ...[
                'Cleaning',
                'Polishing',
                'Leather Conditioning',
                'Odour Removal & Sanitization',
                'Shoelace Cleaning',
              ].map((item) => Padding(
                padding: EdgeInsets.only(bottom: width * 0.009),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.009,
                      height: width * 0.009,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B5E20),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: width * 0.018),
                    Text(
                      item,
                      style: TextStyle(
                        fontSize: width * 0.029,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ],
          ),
        ),
        SizedBox(height: height * 0.027),

        // Shoe Types List
        _buildShoeTypeItem(context, width, 'Formal Shoe Polishing', 75, null),
        _buildShoeTypeItem(context, width, 'Sports Sneakers', 95, null),
        _buildShoeTypeItem(context, width, 'Designer Sneakers', 145, null),
        _buildShoeTypeItem(context, width, 'Formal Shoes', 110, null),
        _buildShoeTypeItem(context, width, 'Designer Formal', 145, null),
        _buildShoeTypeItem(context, width, 'Sandals', 85, null),
        _buildShoeTypeItem(context, width, 'Designer Sandals', 140, null),
        _buildShoeTypeItem(context, width, 'Espadrilles', 90, null),
        _buildShoeTypeItem(context, width, 'Designer Espadrilles', 140, null),
        _buildShoeTypeItem(context, width, 'Kids Shoes', 65, null),
        _buildShoeTypeItem(context, width, 'Boots', 170, 'From'),

        SizedBox(height: height * 0.027),

        // Bundled Packages
        Container(
          padding: EdgeInsets.all(width * 0.036),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7FA),
            borderRadius: BorderRadius.circular(10.8),
          ),
          child: Row(
            children: [
              Icon(Icons.card_giftcard, color: const Color(0xFF00838F), size: width * 0.045),
              SizedBox(width: width * 0.018),
              Expanded(
                child: Text(
                  'Bundled Packages',
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF00838F),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: width * 0.018),
        Text(
          'Each shoe will be evaluated for bundled packages. If needed, we will contact you to recommend any additional work.',
          style: TextStyle(
            fontSize: width * 0.027,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
        SizedBox(height: height * 0.027),

        // Color Touch-ups Section
        _buildExpandableSection(
          context,
          width,
          'Colour Touch-ups',
          50,
          description: 'For an additional AED 50, our team will lightly restore your shoe.',
          includes: [
            'Minor Color Work & Touch-Ups',
            'Minor Stitching',
            'Minor Gluing',
          ],
          comesWith: [
            'Free Stain Protection',
          ],
        ),

        // Full Color Restoration Section
        _buildExpandableSection(
          context,
          width,
          'Full Colour Restoration',
          170,
          description: 'For an additional AED 170, our team will do a full colour restoration on your shoe.',
          includes: [
            'Minor Stitching',
            'Minor Heel Repair',
            'Minor Gluing',
            'Minor Leather Edging',
          ],
          comesWith: [
            'Free Stain Protection',
            'Free Sole Icing',
          ],
        ),

        SizedBox(height: height * 0.027),

        // Other Add-ons
        _buildOtherAddons(context, width),

        SizedBox(height: height * 0.027),
      ],
    );
  }

  Widget _buildShoeTypeItem(BuildContext context, double width, String name, int price, String? prefix) {
    final itemKey = 'shoe_$name';
    final quantity = shoeItems[itemKey] ?? 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.018),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Row(
            children: [
              if (prefix != null)
                Text(
                  '$prefix ',
                  style: TextStyle(
                    fontSize: width * 0.027,
                    color: Colors.grey.shade500,
                  ),
                ),
              Text(
                'AED $price',
                style: TextStyle(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1B5E20),
                ),
              ),
              SizedBox(width: width * 0.027),
              quantity == 0
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    shoeItems[itemKey] = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.036,
                    vertical: width * 0.018,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: width * 0.029,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00E676),
                    ),
                  ),
                ),
              )
                  : Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.018,
                  vertical: width * 0.009,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676).withOpacity(0.2),
                  border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) {
                            shoeItems[itemKey] = quantity - 1;
                          } else {
                            shoeItems.remove(itemKey);
                          }
                        });
                      },
                      child: Icon(Icons.remove, size: width * 0.041, color: const Color(0xFF00E676)),
                    ),
                    SizedBox(width: width * 0.018),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF00E676),
                      ),
                    ),
                    SizedBox(width: width * 0.018),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          shoeItems[itemKey] = quantity + 1;
                        });
                      },
                      child: Icon(Icons.add, size: width * 0.041, color: const Color(0xFF00E676)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection(
      BuildContext context,
      double width,
      String title,
      int price, {
        String? description,
        List<String>? includes,
        List<String>? comesWith,
      }) {
    bool isExpanded = expandedAddons[title] ?? false;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedAddons[title] = !isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.all(width * 0.036),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(10.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'AED $price',
                      style: TextStyle(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF00838F),
                      ),
                    ),
                    SizedBox(width: width * 0.018),
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: const Color(0xFF00838F),
                      size: width * 0.054,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: EdgeInsets.all(width * 0.036),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7FA).withOpacity(0.3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.8),
                bottomRight: Radius.circular(10.8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (description != null) ...[
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: width * 0.029,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: width * 0.027),
                ],
                if (includes != null) ...[
                  Text(
                    'Service may include:',
                    style: TextStyle(
                      fontSize: width * 0.027,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: width * 0.018),
                  ...includes.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: width * 0.009),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.009,
                          height: width * 0.009,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00838F),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: width * 0.027,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                  SizedBox(height: width * 0.027),
                ],
                if (comesWith != null) ...[
                  Text(
                    'This package comes with:',
                    style: TextStyle(
                      fontSize: width * 0.027,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: width * 0.018),
                  ...comesWith.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: width * 0.009),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.009,
                          height: width * 0.009,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00838F),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: width * 0.027,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ],
            ),
          ),
        // SizedBox(height: ResponsiveUtils.height * 0.018),
      ],
    );
  }

  Widget _buildOtherAddons(BuildContext context, double width) {
    final addons = {
      'Stain Protection': 20,
      'Icing Soles': 35,
      'Resoling': 550,
      'Heel Repair': [
        {'name': 'Ladies\' Rubber/Leather Heel Repair', 'price': 85},
        {'name': 'Men\'s Rubber/Leather Heel Repair', 'price': 100},
        {'name': 'Ladies\' Rubber Heel Repiar', 'price': 85},
        {'name': 'Men\'s Rubber Heel Repiar', 'price': 85},
        {'name': 'Heel Tip Repair', 'price': 50},
        {'name': 'Heel Block Replacement', 'price': 200},
        {'name': 'Heel Refix Per Foot', 'price': 85},
      ],
      'Sole Protection': [
        {'name': 'Half Sole Protection', 'price': 150},
        {'name': 'Full Sole Protection', 'price': 170},
      ],
      'Replacement': [
        {'name': 'Elastic Strap Replacement (Per Foot)', 'price': 75},
        {'name': 'Elastic Strap Replacement (Pair)', 'price': 150},
        {'name': 'Tassel Replacement', 'price': 150},
        {'name': 'Boot Zipper Replacement', 'price': 200},
        {'name': 'Sneaker Laces Replacement', 'price': 20},
        {'name': 'Formal Shoe Laces Replacement', 'price': 20},
      ],
      'Inner Lining': [
        {'name': 'Full Inner Lining Replacement', 'price': 150},
        {'name': 'Glissior/Counter Lining Replacement', 'price': 100},
        {'name': 'Leather Insole Replacement', 'price': 100},
      ],
      'Stitching': [
        {'name': 'Major Stitching', 'price': 100},
        {'name': 'Sole Stitching', 'price': 120},
      ],
      'Gluing': [
        {'name': 'Full Sole Gluing', 'price': 100},
        {'name': 'Major Gluing', 'price': 50},
      ],
      'Shoe Stretching': [
        {'name': 'Shoe Stretching', 'price': 70},
        {'name': 'Boot Stretching', 'price': 70},
      ],
    };

    return Container(
      padding: EdgeInsets.all(width * 0.036),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.add_circle_outline, color: const Color(0xFF1B5E20), size: width * 0.045),
              SizedBox(width: width * 0.018),
              Text(
                'Other Add-ons',
                style: TextStyle(
                  fontSize: width * 0.036,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1B5E20),
                ),
              ),
            ],
          ),
          SizedBox(height: width * 0.018),
          Text(
            'Each shoe will be evaluated for any add-ons. If needed, we will contact you to recommend any additional work.',
            style: TextStyle(
              fontSize: width * 0.027,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          // SizedBox(height: height * 0.027),
          // Add all addon sections here...
        ],
      ),
    );
  }

  Widget _buildBagContentOnly(BuildContext context, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sending Info
        Text(
          'Sending Your Bags',
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B5E20),
          ),
        ),
        SizedBox(height: height * 0.018),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: width * 0.029,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
            children: [
              TextSpan(text: 'Use the '),
              TextSpan(
                text: 'Orange Sticker',
                style: TextStyle(
                  color: const Color(0xFFFF6F00),
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: ' to send your bags.\n'),
              TextSpan(text: 'Bags, or any non-shoe items will be '),
              TextSpan(
                text: 'delivered after 7-14 days',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: '.\nWe will contact you to confirm a delivery date'),
            ],
          ),
        ),
        SizedBox(height: height * 0.036),

        // Basic Cleaning Service
        Container(
          padding: EdgeInsets.all(width * 0.036),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cleaning_services, color: const Color(0xFF1B5E20), size: width * 0.045),
                  SizedBox(width: width * 0.018),
                  Text(
                    'Basic Cleaning Service:',
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.027),
              _buildBagSizeItem(context, width, 'Extra Small', 150),
              _buildBagSizeItem(context, width, 'Small', 250),
              _buildBagSizeItem(context, width, 'Medium', 350),
              _buildBagSizeItem(context, width, 'Large', 450),
            ],
          ),
        ),
        SizedBox(height: height * 0.027),

        // Cleaning, Repair, and Restoration
        Text(
          'Cleaning, Repair, and Restoration:',
          style: TextStyle(
            fontSize: width * 0.036,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B5E20),
          ),
        ),
        SizedBox(height: height * 0.018),
        _buildBagSizeItem(context, width, 'Extra Small', 300, prefix: 'From'),
        _buildBagSizeItem(context, width, 'Small', 450, prefix: 'From'),
        _buildBagSizeItem(context, width, 'Medium', 650, prefix: 'From'),
        _buildBagSizeItem(context, width, 'Large', 1150, prefix: 'From'),

        SizedBox(height: height * 0.027),

        // Add-ons Section
        Container(
          padding: EdgeInsets.all(width * 0.036),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.add_circle_outline, color: const Color(0xFF1B5E20), size: width * 0.045),
                  SizedBox(width: width * 0.018),
                  Text(
                    'Add-ons',
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.018),
              Text(
                'Each bag will be evaluated for any add-ons. If needed, we will contact you to recommend any additional work.',
                style: TextStyle(
                  fontSize: width * 0.027,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              SizedBox(height: height * 0.027),

              // Full Cleaning, Repair, Restoration
              _buildBagExpandableSection(
                context,
                width,
                'Full Cleaning, Repair, Restoration',
                description: 'This includes fixing imperfections such as; gold plating, edging, colour restoration, piping, edge reconstruction, etc...',
                excludes: 'zipper replacement, inner lining replacement, replacement of accessories',
                sizes: [
                  {'name': 'Extra Small', 'price': 300},
                  {'name': 'Small', 'price': 450},
                  {'name': 'Medium', 'price': '650-900'},
                  {'name': 'Large', 'price': 1150},
                ],
              ),

              // Other Work
              _buildBagExpandableSection(
                context,
                width,
                'Other Work',
                items: [
                  {'name': 'Metal Plating', 'price': 150},
                  {'name': 'Edge Reconstruction Extra Small/Small', 'price': 150},
                  {'name': 'Edge Reconstruction Medium/Large', 'price': 220},
                  {'name': 'Piping Extra Small/Small', 'price': 100},
                  {'name': 'Piping Medium/Large', 'price': 150},
                  {'name': 'Zipper Replacement Standard Size', 'price': 250},
                  {'name': 'Zipper Replacement Made To Measure', 'price': 550},
                  {'name': 'Inner Lining', 'price': '250-500'},
                  {'name': 'Trim Replacements', 'price': 200},
                ],
              ),

              // Other Items
              _buildBagExpandableSection(
                context,
                width,
                'Other Items',
                items: [
                  {'name': 'Belt Full Restoration And Repair', 'price': 250},
                  {'name': 'Belt Edge Reconstruction', 'price': 100},
                  {'name': 'Belt Metal Plating', 'price': 85},
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.027),
      ],
    );
  }

  Widget _buildBagSizeItem(BuildContext context, double width, String name, dynamic price, {String? prefix}) {
    final itemKey = 'bag_$name';
    final quantity = bagItems[itemKey] ?? 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.018),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: width * 0.032,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Row(
            children: [
              if (prefix != null)
                Text(
                  '$prefix ',
                  style: TextStyle(
                    fontSize: width * 0.027,
                    color: Colors.grey.shade500,
                  ),
                ),
              Text(
                'AED $price',
                style: TextStyle(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1B5E20),
                ),
              ),
              SizedBox(width: width * 0.027),
              quantity == 0
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    bagItems[itemKey] = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.036,
                    vertical: width * 0.018,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: width * 0.029,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00E676),
                    ),
                  ),
                ),
              )
                  : Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.018,
                  vertical: width * 0.009,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676).withOpacity(0.2),
                  border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) {
                            bagItems[itemKey] = quantity - 1;
                          } else {
                            bagItems.remove(itemKey);
                          }
                        });
                      },
                      child: Icon(Icons.remove, size: width * 0.041, color: const Color(0xFF00E676)),
                    ),
                    SizedBox(width: width * 0.018),
                    Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF00E676),
                      ),
                    ),
                    SizedBox(width: width * 0.018),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          bagItems[itemKey] = quantity + 1;
                        });
                      },
                      child: Icon(Icons.add, size: width * 0.041, color: const Color(0xFF00E676)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBagExpandableSection(
      BuildContext context,
      double width,
      String title, {
        String? description,
        String? excludes,
        List<Map<String, dynamic>>? sizes,
        List<Map<String, dynamic>>? items,
      }) {
    bool isExpanded = expandedBagAddons[title] ?? false;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedBagAddons[title] = !isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: width * 0.027),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 0.9),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: const Color(0xFF1B5E20),
                  size: width * 0.054,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: EdgeInsets.symmetric(vertical: width * 0.027),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (description != null) ...[
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: width * 0.029,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: width * 0.027),
                ],
                if (excludes != null) ...[
                  Text(
                    'Excludes: $excludes',
                    style: TextStyle(
                      fontSize: width * 0.027,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: width * 0.027),
                ],
                if (sizes != null)
                  ...sizes.map((size) => Padding(
                    padding: EdgeInsets.only(bottom: width * 0.018),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.009,
                          height: width * 0.009,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B5E20),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Expanded(
                          child: Text(
                            size['name'],
                            style: TextStyle(
                              fontSize: width * 0.029,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Text(
                          'AED ${size['price']}',
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1B5E20),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                if (items != null)
                  ...items.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: width * 0.018),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.009,
                          height: width * 0.009,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B5E20),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Expanded(
                          child: Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: width * 0.029,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Text(
                          'AED ${item['price']}',
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1B5E20),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBedBathContent(BuildContext context, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.036),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: height * 0.225,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE1BEE7), Color(0xFFFF4081)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.8),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: height * 0.027,
                  left: width * 0.045,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bed & Bath',
                        style: TextStyle(
                          fontSize: width * 0.054,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4A148C),
                        ),
                      ),
                      SizedBox(height: width * 0.018),
                      Text(
                        'Clean & Press bag\nfor your home linens',
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: const Color(0xFF4A148C),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: width * 0.027),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.027,
                          vertical: width * 0.018,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4081),
                          borderRadius: BorderRadius.circular(13.5),
                        ),
                        child: Text(
                          'Up to 15 items',
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -width * 0.09,
                  bottom: -height * 0.027,
                  child: Text(
                    '🛏️',
                    style: TextStyle(fontSize: width * 0.36),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.027),
          Text(
            'Fill the bag with up to 15 home linens* and we will have them perfectly cleaned and pressed',
            style: TextStyle(
              fontSize: width * 0.029,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          SizedBox(height: height * 0.036),
          Text(
            'Pricing',
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1B5E20),
            ),
          ),
          SizedBox(height: height * 0.027),
          Container(
            padding: EdgeInsets.all(width * 0.036),
            decoration: BoxDecoration(
              color: const Color(0xFFFF4081).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'AED 85',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(width: width * 0.018),
                        Text(
                          'AED 66 per bag*',
                          style: TextStyle(
                            fontSize: width * 0.036,
                            fontWeight: FontWeight.w900,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.018,
                    vertical: width * 0.009,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676).withOpacity(0.2),
                    border: Border.all(color: const Color(0xFF00E676), width: 1.8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (bedBathQty > 0) {
                            setState(() => bedBathQty--);
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: width * 0.041,
                          color: const Color(0xFF00E676),
                        ),
                      ),
                      SizedBox(width: width * 0.027),
                      Text(
                        bedBathQty.toString(),
                        style: TextStyle(
                          fontSize: width * 0.036,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF00E676),
                        ),
                      ),
                      SizedBox(width: width * 0.027),
                      GestureDetector(
                        onTap: () {
                          setState(() => bedBathQty++);
                        },
                        child: Icon(
                          Icons.add,
                          size: width * 0.041,
                          color: const Color(0xFF00E676),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.018),
          Text(
            '*Maximum 15 items per bag, if you managed to fit more items in the bag, extra items will be charged AED 8 per piece',
            style: TextStyle(
              fontSize: width * 0.024,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          SizedBox(height: width * 0.018),
          Text(
            'Price exclusive of VAT',
            style: TextStyle(
              fontSize: width * 0.024,
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: height * 0.036),
          Text(
            'Items suitable for Bed & Bath',
            style: TextStyle(
              fontSize: width * 0.036,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1B5E20),
            ),
          ),
          SizedBox(height: height * 0.027),
          Wrap(
            spacing: width * 0.045,
            runSpacing: height * 0.027,
            children: [
              _buildBedBathItem(context, width, '🛏️', 'Bedsheet'),
              _buildBedBathItem(context, width, '🛏️', 'Bed cover'),
              _buildBedBathItem(context, width, '🛏️', 'Duvet'),
              _buildBedBathItem(context, width, '🛏️', 'Duvet cover'),
              _buildBedBathItem(context, width, '🛏️', 'Pillow'),
              _buildBedBathItem(context, width, '🛏️', 'Pillow case'),
              _buildBedBathItem(context, width, '🧺', 'Blanket'),
              _buildBedBathItem(context, width, '🧺', 'Towel'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBedBathItem(BuildContext context, double width, String emoji, String name) {
    return Column(
      children: [
        Container(
          width: width * 0.162,
          height: width * 0.162,
          decoration: BoxDecoration(
            color: const Color(0xFFFF4081).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.8),
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(fontSize: width * 0.063),
            ),
          ),
        ),
        SizedBox(height: width * 0.018),
        Text(
          name,
          style: TextStyle(
            fontSize: width * 0.027,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
  // Add this method to your existing LaundryServicePage _buildBottomBar widget

  Widget _buildBottomBar(BuildContext context, double width) {
    final total = _calculateTotal();
    final hasItems = total > 0;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: width * 0.036,
          right: width * 0.036,
          top: width * 0.027,
          bottom: width * 0.045,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated Bill:',
                  style: TextStyle(
                    fontSize: width * 0.032,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  'AED ${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1B5E20),
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.027),
            GestureDetector(
              onTap: hasItems ? _navigateToCheckout : null,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: width * 0.032),
                decoration: BoxDecoration(
                  color: hasItems ? const Color(0xFF00E676) : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(22.5),
                ),
                child: Text(
                  hasItems ? 'Place Order' : 'Please add something',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w700,
                    color: hasItems ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            if (!hasItems)
              Padding(
                padding: EdgeInsets.only(top: width * 0.018),
                child: Text(
                  'Add items to your order to continue',
                  style: TextStyle(
                    fontSize: width * 0.027,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  void _navigateToCheckout() {
    final total = _calculateTotal();

    if (total <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: MediaQuery.of(context).size.width * 0.027),
              Expanded(
                child: Text(
                  'Please add items to your order first',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.032,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.orange.shade700,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    // Create structured order data
    final orderData = _buildOrderData();

    // Navigate to Collection & Delivery page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollectionDeliveryPage(
          totalAmount: total,
          orderDetails: orderData.toMap(),
        ),
      ),
    );
  }

// Add this new helper method to build order data:
  LaundryOrderData _buildOrderData() {
    Map<String, ItemDetail> individualItemsDetails = {};
    Map<String, ItemDetail> shoeItemsDetails = {};
    Map<String, ItemDetail> bagItemsDetails = {};

    // Process individual items (for hanger/iron services)
    if (selectedService == 'hanger' || selectedService == 'iron') {
      selectedItems.forEach((key, quantity) {
        final parts = key.split('_');
        final itemId = parts.isNotEmpty ? parts[0] : key;

        // Find item name and price
        String itemName = _getItemName(itemId);
        double itemPrice = LaundryPriceCalculator.getPriceForItem(key, selectedService);

        individualItemsDetails[key] = ItemDetail(
          name: itemName,
          quantity: quantity,
          price: itemPrice,
        );
      });
    }

    // Process shoe items
    if (selectedService == 'shoe' && selectedCareType == 'shoe') {
      shoeItems.forEach((key, quantity) {
        final shoeName = key.replaceFirst('shoe_', '');
        final price = LaundryPriceCalculator.getPriceForShoe(shoeName);

        shoeItemsDetails[key] = ItemDetail(
          name: shoeName,
          quantity: quantity,
          price: price,
        );
      });
    }

    // Process bag items
    if (selectedService == 'shoe' && selectedCareType == 'bag') {
      bagItems.forEach((key, quantity) {
        final bagName = key.replaceFirst('bag_', '');
        final isRepair = bagName.contains('From');
        final cleanName = bagName.replaceAll('From', '').trim();
        final price = LaundryPriceCalculator.getPriceForBag(cleanName, isRepair);

        bagItemsDetails[key] = ItemDetail(
          name: bagName,
          quantity: quantity,
          price: price,
        );
      });
    }

    return LaundryOrderData(
      serviceType: selectedService,
      individualItems: individualItemsDetails,
      bedBathQty: bedBathQty,
      washFoldQty: washFoldQty,
      shoeItems: shoeItemsDetails,
      bagItems: bagItemsDetails,
      selectedCareType: selectedCareType.isEmpty ? null : selectedCareType,
    );
  }

// Helper method to get item name from ID
  String _getItemName(String itemId) {
    final itemMap = {
      'shirt': 'Shirt',
      't_shirt': 'T Shirt',
      'blouse': 'Blouse',
      'shorts': 'Shorts',
      'pants': 'Pants',
      'skirt': 'Skirt',
      'jeans': 'Jeans',
      'bra': 'Bra',
      'underwear': 'Underwear',
      'bedsheet': 'Bedsheet',
      'floormat': 'Floormat',
      'handkerchief': 'Handkerchief',
      'evening_dress': 'Evening Dress',
      'complex_dress': 'Complex Dress',
      'basic_dress': 'Basic Dress',
      'veil': 'Veil',
      'coat': 'Coat',
      'kandura': 'Kandura',
      'jacket': 'Jacket',
      'abaya': 'Abaya',
      'gathra': 'Gathra',
      'thick_sweater': 'Thick Sweater / Hoodie',
      'sweater': 'Sweater / Hoodie',
      'sports_sweater': 'Sports Sweater / Hoodie',
      'pyjama_pants': 'Pyjama Pants',
      'pyjama_full': 'Pyjama Full',
      'cap': 'Cap',
      'jumpsuit': 'Jumpsuit',
      'sirwal': 'Sirwal',
      'kurta_mens': 'Kurta Mens',
      'kurta_womens': 'Kurta Womens',
      'carpet_regular': 'Carpet Regular (square meter)',
    };

    return itemMap[itemId] ?? itemId;
  }

  double _calculateTotal() {
    final orderData = _buildOrderData();
    return LaundryPriceCalculator.calculateTotal(orderData);
  }


  List<Map<String, dynamic>> _getItemsForCategory(String category) {
    final baseItems = {
      'Tops': [
        {'id': 'shirt', 'name': 'Shirt', 'price': 13},
        {'id': 't_shirt', 'name': 'T Shirt', 'price': 18},
        {'id': 'blouse', 'name': 'Blouse', 'price': 18},
      ],
      'Bottoms': [
        {'id': 'shorts', 'name': 'Shorts', 'price': 18},
        {'id': 'pants', 'name': 'Pants', 'price': 23},
        {'id': 'skirt', 'name': 'Skirt', 'price': 23},
        {'id': 'jeans', 'name': 'Jeans', 'price': 23},
      ],
      'Undergarment': [
        {'id': 'bra', 'name': 'Bra', 'price': 6},
        {'id': 'underwear', 'name': 'Underwear', 'price': 3},
      ],
      'Home Items (Linens)': [
        {'id': 'bedsheet', 'name': 'Bedsheet', 'price': 29},
        {'id': 'floormat', 'name': 'Floormat', 'price': 17},
        {'id': 'handkerchief', 'name': 'Handkerchief', 'price': 6},
      ],
      'Formal': [
        {'id': 'evening_dress', 'name': 'Evening Dress', 'price': 75},
        {'id': 'complex_dress', 'name': 'Complex Dress', 'price': 95},
        {'id': 'basic_dress', 'name': 'Basic Dress', 'price': 45},
        {'id': 'veil', 'name': 'Veil', 'price': 15},
        {'id': 'coat', 'name': 'Coat', 'price': 66},
        {'id': 'kandura', 'name': 'Kandura', 'price': 15},
        {'id': 'jacket', 'name': 'Jacket', 'price': 74},
        {'id': 'abaya', 'name': 'Abaya', 'price': 18},
        {'id': 'gathra', 'name': 'Gathra', 'price': 10},
      ],
      'Others': [
        {'id': 'thick_sweater', 'name': 'Thick Sweater / Hoodie', 'price': 48},
        {'id': 'sweater', 'name': 'Sweater / Hoodie', 'price': 38},
        {'id': 'sports_sweater', 'name': 'Sports Sweater / Hoodie', 'price': 28},
        {'id': 'pyjama_pants', 'name': 'Pyjama Pants', 'price': 18},
        {'id': 'pyjama_full', 'name': 'Pyjama Full', 'price': 15},
        {'id': 'cap', 'name': 'Cap', 'price': 16},
        {'id': 'jumpsuit', 'name': 'Jumpsuit', 'price': 36},
        {'id': 'sirwal', 'name': 'Sirwal', 'price': 12},
        {'id': 'kurta_mens', 'name': 'Kurta Mens', 'price': 15},
        {'id': 'kurta_womens', 'name': 'Kurta Womens', 'price': 31},
        {'id': 'carpet_regular', 'name': 'Carpet Regular (square meter)', 'price': 35},
      ],
    };

    final items = baseItems[category] ?? [];

    // Adjust prices based on selected service
    if (selectedService == 'iron') {
      return items.map((item) {
        return {
          ...item,
          'price': ((item['price'] as int) * 0.7).round(), // 30% cheaper for iron only
        };
      }).toList();
    } else if (selectedService == 'hanger') {
      // Hanger service uses base prices (clean & press)
      return items;
    }

    return items;
  }
}