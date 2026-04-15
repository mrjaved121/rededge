import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';

class RideConfirmationPage extends StatefulWidget {
  const RideConfirmationPage({super.key});

  @override
  State<RideConfirmationPage> createState() => _RideConfirmationPageState();
}

class _RideConfirmationPageState extends State<RideConfirmationPage>
    with TickerProviderStateMixin {
  late GoogleMapController _mapController;
  late AnimationController _progressController;

  final LatLng _initialPosition = const LatLng(25.2048, 55.2708);

  String _currentPhase = 'creating'; // creating, finding, confirmed

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _startPhaseTransition();
  }

  void _startPhaseTransition() async {
    // Phase 1: Creating (3 seconds)
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _currentPhase = 'finding';
        _progressController.forward();
      });
    }

    // Phase 2: Finding (4 seconds)
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _currentPhase = 'confirmed';
      });
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // ============ GOOGLE MAP ============
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12.5,
            ),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
          ),

          // ============ BACK BUTTON ============
          Positioned(
            top: height * 0.05,
            left: width * 0.04,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.all(width * 0.02),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5),
                  ],
                ),
                child: Icon(Icons.arrow_back, size: width * 0.06),
              ),
            ),
          ),

          // ============ DRAGGABLE BOTTOM SHEET ============
          DraggableScrollableSheet(
            initialChildSize: 0.45, // Changed to 0.45 as requested
            minChildSize: 0.45,
            maxChildSize: 0.95, // Changed to 0.95 as requested
            snap: false,
            snapSizes: const [],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(width * 0.06),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Handle bar - MOVED UP HERE (outside the ListView)
                    SizedBox(height: height * 0.015),
                    Center(
                      child: Container(
                        height: height * 0.005,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    // SizedBox(height: height * 0.00),

                    // Content in ListView
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.only(top: 10),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              // vertical: height * 0.0001,
                            ),
                            child: _buildSheetContent(context, width, height),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSheetContent(
      BuildContext context, double width, double height) {
    switch (_currentPhase) {
      case 'creating':
        return _buildCreatingPhase(width, height);
      case 'finding':
        return _buildFindingPhase(width, height);
      case 'confirmed':
        return _buildConfirmedPhase(width, height);
      default:
        return const SizedBox();
    }
  }

  // ============ PHASE 1: Creating ============
  Widget _buildCreatingPhase(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Creating a booking',
          style: TextStyle(
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(height: height * 0.01),
        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: _progressController.value,
            minHeight: 6,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation(Color(0xff0F6A43)),
          ),
        ),
        SizedBox(height: height * 0.025),

        // Pickup
        _buildLocationItem(
          icon: Icons.location_on,
          title: 'My apartment jsbsb',
          subtitle: 'shbs - vsusj - Al Rashidiya - Dubai - Dubai',
          width: width,
        ),
        SizedBox(height: height * 0.03),

        // Destination
        _buildLocationItem(
          icon: Icons.flight,
          title: 'My apartment',
          subtitle: 'owlwlow - Villa 11 - Al Barsha 3 - Dubai',
          width: width,
          trailing: Icons.edit,
        ),
        SizedBox(height: height * 0.045),

        Text(
          'Booking details',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),


        _buildDetailRow('Comfort', Icons.directions_car, width),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),
        _buildDetailRow('Cash', Icons.payment, width),

        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),
        _buildDetailRowWithPrice('Fare', '101 - 131', width),

        SizedBox(height: height * 0.03),
      ],
    );
  }

  // ============ PHASE 2: Finding Captain ============
  Widget _buildFindingPhase(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Finding your Captain',
          style: TextStyle(
            fontSize: width * 0.055,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.015),

        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: _progressController.value,
            minHeight: 6,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation(Color(0xff0F6A43)),
          ),
        ),
        SizedBox(height: height * 0.025),

        // Pickup
        _buildLocationItem(
          icon: Icons.location_on,
          title: 'My apartment jsbsb',
          subtitle: 'shbs - vsusj - Al Rashidiya - Dubai - Dubai',
          width: width,
        ),
        SizedBox(height: height * 0.02),

        // Destination
        _buildLocationItem(
          icon: Icons.flight,
          title: 'My apartment',
          subtitle: 'owlwlow - Villa 11 - Al Barsha 3 - Dubai',
          width: width,
        ),
        SizedBox(height: height * 0.025),

        Text(
          'Booking details',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),


        _buildDetailRow('Comfort', Icons.directions_car, width),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),
        _buildDetailRow('Cash', Icons.payment, width),

        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),
        _buildDetailRowWithPrice('Fare', '101 - 131', width),

        SizedBox(height: height * 0.03),

      ],
    );
  }

  // ============ PHASE 3: Captain On The Way ============
  Widget _buildConfirmedPhase(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Captain is on the way',
          style: TextStyle(
            fontSize: width * 0.055,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.025),

        // Car Card
        Container(
          padding: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 0.06),
              topRight: Radius.circular(width * 0.06),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'White Tesla Model 3',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: width * 0.015),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03,
                        vertical: width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkGreen,
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      child: Text(
                        'L75377',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.25,
                height: width * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Icon(Icons.directions_car, size: width * 0.1),
              ),
            ],
          ),
        ),
        // SizedBox(height: height * 0.025),

        // Driver Card
        Container(
          padding: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * 0.06),
              bottomRight: Radius.circular(width * 0.06),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: width * 0.08,
                backgroundColor: Colors.grey[300],
                child: Text(
                  'SA',
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Captain Shan Ahmad',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: width * 0.01),
                    Row(
                      children: [
                        Icon(Icons.star,
                            size: width * 0.04, color: Colors.teal),
                        SizedBox(width: width * 0.02),
                        Text(
                          '4.9',
                          style: TextStyle(fontSize: width * 0.035),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(width * 0.03),
                child: Icon(Icons.call, size: width * 0.05),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.03),

        // Trip Details
        Text(
          'Trip details',
          style: TextStyle(
            fontSize: width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.015),
        Container(
          width: double.infinity,
          height:2 ,
          color: AppColors.lightGrey,
        ),

        SizedBox(height: height * 0.015),

        _buildLocationItem(
          icon: Icons.location_on,
          title: 'My apartment jsbsb',
          subtitle: 'shbs - vsusj - Al Rashidiya - Dubai - Dubai',
          width: width,
          trailing: Icons.edit,
        ),
        SizedBox(height: height * 0.015),

        _buildLocationItem(
          icon: Icons.flight,
          title: 'My apartment',
          subtitle: 'owlwlow - Villa 11 - Al Barsha 3 - Dubai',
          width: width,
          trailing: Icons.edit,
        ),
        SizedBox(height: height * 0.03),

        // Booking Details
        Text(
          'Booking details',
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),


        _buildDetailRow('Comfort', Icons.directions_car, width),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),
        _buildDetailRow('Cash', Icons.payment, width),

        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),
        _buildDetailRowWithPrice('Fare', '101 - 131', width),

        SizedBox(height: height * 0.03),

        // Manage Ride
        Text(
          'Manage ride',
          style: TextStyle(
            fontSize: width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),


        _buildManageOption('Share details', Icons.share, width),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),

        _buildManageOption('Get support', Icons.support_agent, width),
        SizedBox(height: height * 0.011),
        Container(
          height: 2,
          width: double.infinity,
          color: AppColors.lightGrey,

        ),
        SizedBox(height: height * 0.011),

        _buildManageOption('Cancel ride', Icons.close, width, isRed: true),

        SizedBox(height: height * 0.03),
      ],
    );
  }

  // ============ Helper Widgets ============

  Widget _buildLocationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required double width,
    IconData? trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(width * 0.013),
          decoration: BoxDecoration(
            color: AppColors.darkGreen,
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
          child: Icon(icon, color: Colors.white, size: width * 0.045),
        ),
        SizedBox(width: width * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: width * 0.005),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: width * 0.032,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (trailing != null)
          Icon(trailing, color: Colors.grey[400], size: width * 0.048),
      ],
    );
  }

  Widget _buildDetailRow(String label, IconData icon, double width) {
    return Row(
      children: [
        Icon(icon, size: width * 0.048, color: Colors.black),
        SizedBox(width: width * 0.03),
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.038,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithPrice(String label, String price, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.receipt, size: width * 0.048, color: Colors.black),
            SizedBox(width: width * 0.03),
            Text(
              label,
              style: TextStyle(
                fontSize: width * 0.038,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Text(
          '₪ $price',
          style: TextStyle(
            fontSize: width * 0.033,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildManageOption(String label, IconData icon, double width,
      {bool isRed = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: width * 0.048,
              color: isRed ? Colors.red : Colors.grey[600],
            ),
            SizedBox(width: width * 0.03),
            Text(
              label,
              style: TextStyle(
                fontSize: width * 0.038,
                fontWeight: FontWeight.w500,
                color: isRed ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios, size: width * 0.035, color: Colors.grey),
      ],
    );
  }
}
