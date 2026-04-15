import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'enter_amout_page.dart';
// import 'enter_amount.dart';

class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({Key? key}) : super(key: key);

  @override
  State<AddNewContactScreen> createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateButtonState);
    _phoneController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {});
  }

  bool get _isFormValid {
    return _nameController.text.isNotEmpty && _phoneController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Added SingleChildScrollView
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add a new contact',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Their details will be added to your Careem Pay contacts list.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Contact phone number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFF01411C),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+92',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: '301 2345678',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32), // Reduced space before button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isFormValid
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnterAmountScreen(
                            name: _nameController.text,
                            phone: '+92${_phoneController.text}',
                          ),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid
                          ? const Color(0xFF0D4D3D)
                          : Colors.grey[300],
                      foregroundColor: _isFormValid ? Colors.white : Colors.black38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add this contact',
                      style: TextStyle(
                        fontSize: 18,
                        color: _isFormValid ? Colors.white : Colors.black38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Added bottom padding for safety
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'enter _amount.dart';
// // import 'enter_amount.dart';
//
// class AddNewContactScreen extends StatefulWidget {
//   const AddNewContactScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddNewContactScreen> createState() => _AddNewContactScreenState();
// }
//
// class _AddNewContactScreenState extends State<AddNewContactScreen> {
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController.addListener(_updateButtonState);
//     _phoneController.addListener(_updateButtonState);
//   }
//
//   void _updateButtonState() {
//     setState(() {});
//   }
//
//   bool get _isFormValid {
//     return _nameController.text.isNotEmpty && _phoneController.text.isNotEmpty;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Add a new contact',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Their details will be added to your Careem Pay contacts list.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black54,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               const Text(
//                 'Name',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 'Contact phone number',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Container(
//                     width: 120,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black26),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 24,
//                           height: 24,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF01411C),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Center(
//                             child: Icon(
//                               Icons.star,
//                               color: Colors.white,
//                               size: 14,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         const Text(
//                           '+92',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(width: 4),
//                         const Icon(Icons.keyboard_arrow_down),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextField(
//                       controller: _phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         hintText: '301 2345678',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: _isFormValid
//                       ? () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EnterAmountScreen(
//                           name: _nameController.text,
//                           phone: '+92${_phoneController.text}',
//                         ),
//                       ),
//                     );
//                   }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _isFormValid
//                         ? const Color(0xFF0D4D3D)
//                         : Colors.grey[300],
//                     foregroundColor: _isFormValid ? Colors.white : Colors.black38,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Add this contact',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: _isFormValid ? Colors.white : Colors.black38,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
// }