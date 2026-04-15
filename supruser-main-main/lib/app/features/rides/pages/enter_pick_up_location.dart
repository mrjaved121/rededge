import 'package:flutter/material.dart';
import 'confirm_pick_up.dart';

class EnterPickUpLocationPage extends StatefulWidget {
  const EnterPickUpLocationPage({Key? key}) : super(key: key);

  @override
  State<EnterPickUpLocationPage> createState() =>
      _EnterPickUpLocationPageState();
}

class _EnterPickUpLocationPageState extends State<EnterPickUpLocationPage> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  bool _isPickupFocused = false;
  bool _isDestinationFocused = false;
  String _activeTab = 'suggested';
  bool _showList = false;

  final List<Map<String, String>> _allLocations = [
    {
      'title': 'My apartment',
      'distance': '6.5 km',
      'address': 'bajb - bainq - Al Barsha 3 - Dubai'
    },
    {
      'title': 'Block U - 17/3 - University 1 Interchange',
      'distance': '41 km',
      'address':
      'Block U - 17/3 - University 1 Interchange Street - University City - Muwailih - Sharjah'
    },
    {
      'title': 'U-Power Generation FZC - Unnamed Road',
      'distance': '48 km',
      'address':
      'U-Power Generation FZC - Unnamed Road - Sharjah International Airport - Sharjah'
    },
    {
      'title': 'Tamweel Tower - Cluster U - JLT',
      'distance': '1.2 km',
      'address':
      'Tamweel Tower - Cluster U - JLT - Jumeirah Lakes Towers - Dubai'
    },
  ];

  final List<Map<String, String>> _savedLocations = [
    {
      'title': 'My apartment',
      'distance': '6.5 km',
      'address': 'bajb - bainq - Al Barsha 3 - Dubai'
    },
    {
      'title': 'Tamweel Tower - Cluster U - JLT',
      'distance': '1.2 km',
      'address':
      'Tamweel Tower - Cluster U - JLT - Jumeirah Lakes Towers - Dubai'
    },
  ];

  final List<Map<String, String>> _airportLocations = [
    {
      'title': 'Dubai International Airport (DXB)',
      'distance': '12 km',
      'address': 'Airport Rd - Garhoud - Dubai'
    },
    {
      'title': 'Sharjah International Airport (SHJ)',
      'distance': '45 km',
      'address': 'Al Dhaid Rd - Sharjah'
    },
  ];

  List<Map<String, String>> _filteredPickupLocations = [];
  List<Map<String, String>> _filteredDestinationLocations = [];

  @override
  void initState() {
    super.initState();
    _pickupController.addListener(_filterPickupLocations);
    _destinationController.addListener(_filterDestinationLocations);
  }

  void _filterPickupLocations() {
    setState(() {
      if (_pickupController.text.isEmpty) {
        _filteredPickupLocations = [];
      } else {
        _filteredPickupLocations = _allLocations
            .where((location) =>
        location['title']!
            .toLowerCase()
            .contains(_pickupController.text.toLowerCase()) ||
            location['address']!
                .toLowerCase()
                .contains(_pickupController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _filterDestinationLocations() {
    setState(() {
      if (_destinationController.text.isEmpty) {
        _filteredDestinationLocations = [];
      } else {
        _filteredDestinationLocations = _allLocations
            .where((location) =>
        location['title']!
            .toLowerCase()
            .contains(_destinationController.text.toLowerCase()) ||
            location['address']!
                .toLowerCase()
                .contains(_destinationController.text.toLowerCase()))
            .toList();
      }
    });
  }

  void _selectPickupLocation(Map<String, String> location) {
    _pickupController.text = location['title']!;
    setState(() {
      _isPickupFocused = false;
      _filteredPickupLocations = [];
    });
  }

  void _selectDestinationLocation(Map<String, String> location) {
    _destinationController.text = location['title']!;
    setState(() {
      _isDestinationFocused = false;
      _filteredDestinationLocations = [];
    });

    // ✅ Navigate to Confirm screen when destination selected
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConfirmPickupPage()),
    );
  }

  void _clearPickup() {
    _pickupController.clear();
    setState(() {
      _isPickupFocused = true;
      _filteredPickupLocations = [];
    });
  }

  void _clearDestination() {
    _destinationController.clear();
    setState(() {
      _isDestinationFocused = true;
      _filteredDestinationLocations = [];
    });
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  double font(num size) => size * (MediaQuery.of(context).size.width / 400);
  double pad(num val) => val * (MediaQuery.of(context).size.width / 400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: pad(16), vertical: pad(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: pad(24)),
              _buildLocationInputCard(context),
              SizedBox(height: pad(16)),

              if (_isPickupFocused && _filteredPickupLocations.isNotEmpty)
                _buildLocationList(
                    context, _filteredPickupLocations, _selectPickupLocation),

              if (_isDestinationFocused &&
                  _filteredDestinationLocations.isNotEmpty)
                _buildLocationList(context, _filteredDestinationLocations,
                    _selectDestinationLocation),

              if (!_isPickupFocused && !_isDestinationFocused)
                Column(
                  children: [
                    SizedBox(height: pad(24)),
                    _buildTabButtons(context),
                    SizedBox(height: pad(20)),
                    if (_showList) _buildSuggestedLocationsList(context),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: pad(44),
            height: pad(44),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.arrow_back, color: Colors.black)),
          ),
        ),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: pad(14), vertical: pad(8)),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1),
                child: Image.asset(
                  "assets/images/dubaiIcon.png",
                  fit: BoxFit.cover,
                  width: pad(25),
                  height: pad(16),
                ),
              ),
              const SizedBox(width: 8),
              Text('Dubai',
                  style: TextStyle(
                      fontSize: font(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInputCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(pad(16)),
      child: Column(
        children: [
          _buildLocationInput(
              context,
              'assets/images/meniconwave.png',
              'Enter your pickup',
              _pickupController,
              _isPickupFocused,
              _clearPickup,
              true, () {
            setState(() {
              _isPickupFocused = true;
              _isDestinationFocused = false;
            });
          }),
          SizedBox(height: pad(16)),
          Divider(color: Colors.grey.shade300, height: 1, thickness: 1),
          SizedBox(height: pad(16)),
          _buildLocationInput(
              context,
              'assets/images/doubleflagicon.png',
              'Enter your destination',
              _destinationController,
              _isDestinationFocused,
              _clearDestination,
              false, () {
            setState(() {
              _isDestinationFocused = true;
              _isPickupFocused = false;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildLocationInput(
      BuildContext context,
      dynamic icon,
      String hint,
      TextEditingController controller,
      bool focused,
      VoidCallback onClear,
      bool showMap,
      VoidCallback onFocus,
      ) {
    return Row(
      children: [
        Container(
          width: pad(44),
          height: pad(44),
          decoration: BoxDecoration(
            color: Colors.teal.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.asset(
              icon,
              width: pad(24),
              height: pad(24),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: pad(12)),
        Expanded(
          child: TextField(
            controller: controller,
            onTap: onFocus,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
              TextStyle(color: Colors.grey.shade400, fontSize: font(14)),
              border: InputBorder.none,
            ),
          ),
        ),
        if (controller.text.isNotEmpty)
          GestureDetector(
            onTap: onClear,
            child: Icon(Icons.close, color: Colors.grey.shade600, size: pad(20)),
          )
        else if (showMap)
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/images/mapnewverion.png',
              width: pad(50),
              height: pad(50),
              fit: BoxFit.contain,
            ),
          ),
      ],
    );
  }

  Widget _buildLocationList(BuildContext context, List<Map<String, String>> list,
      Function(Map<String, String>) onSelect) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, i) {
          final loc = list[i];
          return InkWell(
            onTap: () => onSelect(loc),
            child: Padding(
              padding: EdgeInsets.all(pad(12)),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: Colors.grey.shade600, size: pad(18)),
                  SizedBox(width: pad(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(loc['title']!,
                            style: TextStyle(
                                fontSize: font(14),
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 4),
                        Text(loc['distance']!,
                            style: TextStyle(
                                fontSize: font(12),
                                color: Colors.grey.shade600)),
                        SizedBox(height: 4),
                        Text(loc['address']!,
                            style: TextStyle(
                                fontSize: font(12),
                                color: Colors.grey.shade500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabButtons(BuildContext context) {
    return Row(
      children: [
        _buildTabButton(context, 'Suggested', _activeTab == 'suggested', () {
          setState(() {
            _activeTab = 'suggested';
            _showList = true;
          });
        }),
        SizedBox(width: pad(12)),
        _buildTabButton(context, 'Saved', _activeTab == 'saved', () {
          setState(() {
            _activeTab = 'saved';
            _showList = true;
          });
        }),
        SizedBox(width: pad(12)),
        _buildTabButton(context, 'Airport', _activeTab == 'airport', () {
          setState(() {
            _activeTab = 'airport';
            _showList = true;
          });
        }),
      ],
    );
  }

  Widget _buildTabButton(
      BuildContext context, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        EdgeInsets.symmetric(horizontal: pad(16), vertical: pad(10)),
        decoration: BoxDecoration(
          color: active ? Colors.teal.shade900 : Colors.white,
          border: Border.all(
              color: active ? Colors.teal.shade900 : Colors.grey.shade300,
              width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: font(14),
                color: active ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildSuggestedLocationsList(BuildContext context) {
    final list = _activeTab == 'suggested'
        ? _allLocations
        : _activeTab == 'saved'
        ? _savedLocations
        : _airportLocations;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final location = list[index];
        return Container(
          margin: EdgeInsets.only(bottom: pad(12)),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(pad(16)),
          child: Row(
            children: [
              Container(
                width: pad(44),
                height: pad(44),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Icon(Icons.location_on,
                        color: Colors.teal.shade900, size: pad(20))),
              ),
              SizedBox(width: pad(12)),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(location['title']!,
                          style: TextStyle(
                              fontSize: font(14),
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      const SizedBox(height: 6),
                      Text(location['distance']!,
                          style: TextStyle(
                              fontSize: font(12),
                              color: Colors.grey.shade700)),
                      const SizedBox(height: 4),
                      Text(location['address']!,
                          style: TextStyle(
                              fontSize: font(12),
                              color: Colors.grey.shade600)),
                    ]),
              )
            ],
          ),
        );
      },
    );
  }
}