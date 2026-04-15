import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/features/home_services/pages/home_cleaning/widgets/customappbar.dart';
import 'package:suprapp/app/features/home_services/pages/laundry_service/checkoutpage.dart';

import 'collection_delivery_provider.dart';


class CollectionDeliveryPage extends StatelessWidget {
  final double totalAmount;
  final Map<String, dynamic> orderDetails;

  const CollectionDeliveryPage({
    Key? key,
    required this.totalAmount,
    required this.orderDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CollectionDeliveryProvider(),
      child: _CollectionDeliveryContent(
        totalAmount: totalAmount,
        orderDetails: orderDetails,
      ),
    );
  }
}

class _CollectionDeliveryContent extends StatelessWidget {
  final double totalAmount;
  final Map<String, dynamic> orderDetails;

  const _CollectionDeliveryContent({
    required this.totalAmount,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(title: "Laundry Service", showBackButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Progress indicator
                Container(
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.045),
                  child: LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF00E676)),
                  ),
                ),
                SizedBox(height: height * 0.027),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        'Collection & Delivery',
                        style: TextStyle(
                          fontSize: width * 0.063,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: width * 0.018),
                      Text(
                        'A Washmen captain will collect your items',
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: height * 0.036),

                      // Add Address
                      _AddressSection(),
                      SizedBox(height: height * 0.018),

                      // Schedule Collection
                      _ScheduleSection(
                        title: 'Schedule Collection',
                        icon: Icons.access_time,
                        isCollection: true,
                      ),
                      SizedBox(height: height * 0.018),

                      // Schedule Delivery
                      _ScheduleSection(
                        title: 'Schedule Delivery',
                        icon: Icons.calendar_today,
                        isCollection: false,
                      ),
                      SizedBox(height: height * 0.018),

                      // Driver Instructions
                      _DriverInstructionsSection(),
                      SizedBox(height: height * 0.027),

                      // How do I get the bags
                      _ExpandableInfoSection(),
                      // ADD PADDING AT BOTTOM TO ACCOUNT FOR BOTTOM BAR
                      SizedBox(height: height * 0.22), // Increased from 0.135
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom bar
          _BottomBar(
            totalAmount: totalAmount,
            orderDetails: orderDetails,
          ),
        ],
      ),
    );
  }
}

// ==================== ADDRESS SECTION ====================
class _AddressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CollectionDeliveryProvider>(context);

    return GestureDetector(
      onTap: () {
        provider.setAddress('Hotel, The Villa, 45');
      },
      child: Container(
        padding: EdgeInsets.all(width * 0.036),
        decoration: BoxDecoration(
          color: provider.selectedAddress != null ? Colors.white : const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: provider.selectedAddress != null ? Colors.grey.shade300 : const Color(0xFF00E676),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.027),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on,
                color: const Color(0xFF00E676),
                size: width * 0.054,
              ),
            ),
            SizedBox(width: width * 0.027),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.selectedAddress ?? 'Add Address',
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w700,
                      color: provider.selectedAddress != null
                          ? Colors.black
                          : const Color(0xFF00E676),
                    ),
                  ),
                  if (provider.selectedAddress != null)
                    Text(
                      'Hotel, The Villa, 45, -, Vb',
                      style: TextStyle(
                        fontSize: width * 0.029,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              provider.selectedAddress != null ? Icons.edit : Icons.arrow_forward_ios,
              color: Colors.grey.shade600,
              size: width * 0.045,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SCHEDULE SECTION ====================
class _ScheduleSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isCollection;

  const _ScheduleSection({
    required this.title,
    required this.icon,
    required this.isCollection,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CollectionDeliveryProvider>(context);

    final date = isCollection ? provider.collectionDate : provider.deliveryDate;
    final time = isCollection ? provider.collectionTime : provider.deliveryTime;
    final hasValue = date != null && time != null;

    return GestureDetector(
      onTap: () {
        if (isCollection) {
          _showCollectionSchedule(context);
        } else {
          _showDeliverySchedule(context);
        }
      },
      child: Container(
        padding: EdgeInsets.all(width * 0.036),
        decoration: BoxDecoration(
          color: hasValue ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.027),
              decoration: BoxDecoration(
                color: hasValue ? const Color(0xFFE8F5E9) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: hasValue ? const Color(0xFF00E676) : Colors.grey.shade400,
                size: width * 0.054,
              ),
            ),
            SizedBox(width: width * 0.027),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w600,
                      color: hasValue ? Colors.black : Colors.grey.shade400,
                    ),
                  ),
                  if (hasValue)
                    Text(
                      '$date, $time',
                      style: TextStyle(
                        fontSize: width * 0.029,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: width * 0.045,
            ),
          ],
        ),
      ),
    );
  }

  void _showCollectionSchedule(BuildContext context) {
    final provider = Provider.of<CollectionDeliveryProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) => ChangeNotifierProvider.value(
        value: provider,
        child: _CollectionScheduleSheet(),
      ),
    );
  }

  void _showDeliverySchedule(BuildContext context) {
    final provider = Provider.of<CollectionDeliveryProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) => ChangeNotifierProvider.value(
        value: provider,
        child: _DeliveryScheduleSheet(),
      ),
    );
  }
}

// ==================== DRIVER INSTRUCTIONS SECTION ====================
class _DriverInstructionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CollectionDeliveryProvider>(context);

    // CHECK IF INSTRUCTIONS ARE SET
    final hasInstructions = provider.collectionInstruction != 'no_preference' ||
        provider.deliveryInstruction != 'no_preference';

    return GestureDetector(
      onTap: () => _showDriverInstructions(context),
      child: Container(
        padding: EdgeInsets.all(width * 0.036),
        decoration: BoxDecoration(
          color: hasInstructions ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasInstructions ? const Color(0xFF00E676) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.027),
              decoration: BoxDecoration(
                color: hasInstructions ? const Color(0xFFE8F5E9) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_shipping,
                color: hasInstructions ? const Color(0xFF00E676) : Colors.grey.shade600,
                size: width * 0.054,
              ),
            ),
            SizedBox(width: width * 0.027),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver Instructions',
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w600,
                      color: hasInstructions ? Colors.black : Colors.grey.shade600,
                    ),
                  ),
                  if (hasInstructions)
                    Text(
                      'Instructions added',
                      style: TextStyle(
                        fontSize: width * 0.029,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: width * 0.045,
            ),
          ],
        ),
      ),
    );
  }

  void _showDriverInstructions(BuildContext context) {
    final provider = Provider.of<CollectionDeliveryProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) => ChangeNotifierProvider.value(
        value: provider,
        child: _DriverInstructionsSheet(),
      ),
    );
  }
}

// ==================== EXPANDABLE INFO ====================
class _ExpandableInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Text('🛍️', style: TextStyle(fontSize: width * 0.054)),
          title: Text(
            'How do I get the bags?',
            style: TextStyle(
              fontSize: width * 0.032,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.036),
              child: Text(
                'Our Washmen captain will bring the bags when they come to collect your items. You can use these bags for future orders.',
                style: TextStyle(
                  fontSize: width * 0.029,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== BOTTOM BAR ====================
class _BottomBar extends StatelessWidget {
  final double totalAmount;
  final Map<String, dynamic> orderDetails;

  const _BottomBar({
    required this.totalAmount,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CollectionDeliveryProvider>(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(width * 0.045),
        decoration: BoxDecoration(
          color: Colors.white,
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
            // Promo code
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.036,
                vertical: width * 0.027,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer, size: width * 0.054),
                  SizedBox(width: width * 0.027),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AED 30 Promo',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Use Code CAREEM30',
                          style: TextStyle(
                            fontSize: width * 0.027,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: width * 0.027),

            // Next button
            GestureDetector(
              onTap: provider.canProceed()
                  ? () => _proceedToCheckout(context, provider)
                  : null,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: width * 0.036),
                decoration: BoxDecoration(
                  color: provider.canProceed()
                      ? const Color(0xFF00E676)
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _proceedToCheckout(BuildContext context, CollectionDeliveryProvider provider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LaundaryCheckoutPage(
          totalAmount: totalAmount,
          orderDetails: {
            ...orderDetails,
            ...provider.getOrderDetailsMap(),
          },
        ),
      ),
    );
  }
}

// ==================== COLLECTION SCHEDULE SHEET ====================
class _CollectionScheduleSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<CollectionDeliveryProvider>(context);

    return Container(
      padding: EdgeInsets.all(width * 0.045),
      constraints: BoxConstraints(
        maxHeight: height * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: width * 0.027),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Text(
            'Collection In Person',
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: height * 0.027),

          // Days Selection
          SizedBox(
            height: height * 0.08,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.collectionDays.length,
              itemBuilder: (context, index) {
                bool isSelected = provider.selectedCollectionDayIndex == index;
                return GestureDetector(
                  onTap: () {
                    if (provider.selectedCollectionTimeIndex == -1) {
                      provider.setCollectionSchedule(index, 0);
                    } else {
                      provider.setCollectionSchedule(index, provider.selectedCollectionTimeIndex);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: width * 0.018),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.036,
                      vertical: width * 0.018,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFE8F5E9) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        provider.collectionDays[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.029,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? const Color(0xFF00E676) : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: height * 0.027),

          // Time Slots Selection
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: height * 0.245,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.2,
                  crossAxisSpacing: width * 0.018,
                  mainAxisSpacing: width * 0.018,
                ),
                itemCount: provider.collectionTimes.length,
                itemBuilder: (context, index) {
                  bool isSelected = provider.selectedCollectionTimeIndex == index;
                  return GestureDetector(
                    onTap: () {
                      if (provider.selectedCollectionDayIndex == -1) {
                        provider.setCollectionSchedule(0, index);
                      } else {
                        provider.setCollectionSchedule(provider.selectedCollectionDayIndex, index);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: width * 0.018,
                        horizontal: width * 0.009,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          provider.collectionTimes[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.026,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? const Color(0xFF00E676) : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: height * 0.027),

          ElevatedButton(
            onPressed: provider.selectedCollectionDayIndex != -1 &&
                provider.selectedCollectionTimeIndex != -1
                ? () => Navigator.pop(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: provider.selectedCollectionDayIndex != -1 &&
                  provider.selectedCollectionTimeIndex != -1
                  ? const Color(0xFF00E676)
                  : Colors.grey.shade400,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: Text(
              'Done',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width * 0.036,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== DELIVERY SCHEDULE SHEET ====================
class _DeliveryScheduleSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<CollectionDeliveryProvider>(context);

    return Container(
      padding: EdgeInsets.all(width * 0.045),
      constraints: BoxConstraints(
        maxHeight: height * 0.75,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: width * 0.027),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Text(
            'Delivery Schedule',
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: height * 0.027),

          // Delivery Type
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => provider.setDeliveryType('door'),
                  child: Container(
                    padding: EdgeInsets.all(width * 0.036),
                    decoration: BoxDecoration(
                      color: provider.deliveryType == 'door'
                          ? const Color(0xFFE8F5E9)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: provider.deliveryType == 'door'
                            ? const Color(0xFF00E676)
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.door_front_door,
                          size: width * 0.09,
                          color: provider.deliveryType == 'door'
                              ? const Color(0xFF00E676)
                              : Colors.grey.shade600,
                        ),
                        SizedBox(height: width * 0.018),
                        Text(
                          'At door',
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w600,
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
                  onTap: () => provider.setDeliveryType('person'),
                  child: Container(
                    padding: EdgeInsets.all(width * 0.036),
                    decoration: BoxDecoration(
                      color: provider.deliveryType == 'person'
                          ? const Color(0xFFE8F5E9)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: provider.deliveryType == 'person'
                            ? const Color(0xFF00E676)
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          size: width * 0.09,
                          color: provider.deliveryType == 'person'
                              ? const Color(0xFF00E676)
                              : Colors.grey.shade600,
                        ),
                        SizedBox(height: width * 0.018),
                        Text(
                          'In person',
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w600,
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

          // Days
          SizedBox(
            height: height * 0.08,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.deliveryDays.length,
              itemBuilder: (context, index) {
                bool isSelected = provider.selectedDeliveryDayIndex == index;
                return GestureDetector(
                  onTap: () {
                    if (provider.selectedDeliveryTimeIndex == -1) {
                      provider.setDeliverySchedule(index, 0);
                    } else {
                      provider.setDeliverySchedule(index, provider.selectedDeliveryTimeIndex);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: width * 0.018),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.036,
                      vertical: width * 0.018,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFE8F5E9) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        provider.deliveryDays[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.029,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? const Color(0xFF00E676) : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: height * 0.027),

          // Time Slots
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: height * 0.189,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: provider.deliveryTimes.length,
                itemBuilder: (context, index) {
                  bool isSelected = provider.selectedDeliveryTimeIndex == index;
                  return GestureDetector(
                    onTap: () {
                      if (provider.selectedDeliveryDayIndex == -1) {
                        provider.setDeliverySchedule(0, index);
                      } else {
                        provider.setDeliverySchedule(provider.selectedDeliveryDayIndex, index);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: width * 0.018),
                      padding: EdgeInsets.symmetric(
                        vertical: width * 0.027,
                        horizontal: width * 0.027,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          provider.deliveryTimes[index],
                          style: TextStyle(
                            fontSize: width * 0.029,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? const Color(0xFF00E676) : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: height * 0.027),

          Text(
            provider.deliveryType == 'door'
                ? 'We\'ll hang your clean laundry outside your door'
                : 'We\'ll deliver to you in person',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width * 0.029,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: height * 0.027),

          ElevatedButton(
            onPressed: provider.selectedDeliveryDayIndex != -1 &&
                provider.selectedDeliveryTimeIndex != -1
                ? () => Navigator.pop(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: provider.selectedDeliveryDayIndex != -1 &&
                  provider.selectedDeliveryTimeIndex != -1
                  ? const Color(0xFF00E676)
                  : Colors.grey.shade400,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width * 0.036,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== DRIVER INSTRUCTIONS SHEET ====================
class _DriverInstructionsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = Provider.of<CollectionDeliveryProvider>(context);

    final collectionOptions = [
      {'value': 'no_preference', 'label': 'No preference'},
      {'value': 'ring_bell', 'label': 'Ring the door bell'},
      {'value': 'knock', 'label': 'Knock on the door'},
      {'value': 'bags_outside', 'label': 'Do not disturb, bags outside'},
      {'value': 'call_me', 'label': 'Call me when you arrive'},
    ];

    final deliveryOptions = [
      {'value': 'no_preference', 'label': 'No preference'},
      {'value': 'hang_door', 'label': 'Hang on door handle'},
      {'value': 'concierge', 'label': 'At concierge / reception'},
    ];

    return Container(
      padding: EdgeInsets.all(width * 0.045),
      constraints: BoxConstraints(
        maxHeight: height * 0.8,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: width * 0.027),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Text(
              'Driver Instructions',
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: width * 0.036),

            Text(
              'Collection',
              style: TextStyle(
                fontSize: width * 0.036,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: width * 0.018),

            // Collection Options
            ...collectionOptions.map((option) {
              bool isSelected = provider.collectionInstruction == option['value'];
              return GestureDetector(
                onTap: () => provider.setCollectionInstruction(option['value']!),
                child: Container(
                  margin: EdgeInsets.only(bottom: width * 0.018),
                  padding: EdgeInsets.symmetric(
                    vertical: width * 0.027,
                    horizontal: width * 0.027,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option['label']!,
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: Colors.black,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      Container(
                        width: width * 0.054,
                        height: width * 0.054,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                          child: Container(
                            width: width * 0.027,
                            height: width * 0.027,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF00E676),
                            ),
                          ),
                        )
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: width * 0.036),

            Text(
              'Laundry Delivery',
              style: TextStyle(
                fontSize: width * 0.036,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: width * 0.018),

            // Delivery Options
            ...deliveryOptions.map((option) {
              bool isSelected = provider.deliveryInstruction == option['value'];
              return GestureDetector(
                onTap: () => provider.setDeliveryInstruction(option['value']!),
                child: Container(
                  margin: EdgeInsets.only(bottom: width * 0.018),
                  padding: EdgeInsets.symmetric(
                    vertical: width * 0.027,
                    horizontal: width * 0.027,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option['label']!,
                        style: TextStyle(
                          fontSize: width * 0.032,
                          color: Colors.black,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      Container(
                        width: width * 0.054,
                        height: width * 0.054,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? const Color(0xFF00E676) : Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                          child: Container(
                            width: width * 0.027,
                            height: width * 0.027,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF00E676),
                            ),
                          ),
                        )
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: width * 0.036),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E676),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 0,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: width * 0.036,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}