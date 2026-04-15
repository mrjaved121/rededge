import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suprapp/app/features/supr_pay/pages/review_transfer.dart';


class EnterAmountScreen extends StatefulWidget {
  final String name;
  final String phone;

  const EnterAmountScreen({
    Key? key,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();

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
        title: const Text(
          'Enter amount',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Avatar with verified badge
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            widget.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF00A859),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.phone,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        prefixText: 'PKR ',
                        prefixStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                        suffixIcon: _amountController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () {
                            setState(() {
                              _amountController.clear();
                            });
                          },
                        )
                            : null,
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF00A859),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _messageController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Type a message for ${widget.name}',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom section - fixed at bottom
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF004D3D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Instant, reliable and secure fund transfers',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _amountController.text.trim().isNotEmpty
                          ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewTransferScreen(
                              name: widget.name,
                              phone: widget.phone,
                              amount: _amountController.text,
                            ),
                          ),
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF172D0C),
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _amountController.text.trim().isNotEmpty
                              ? Colors.white
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:suprapp/app/features/supr_pay/pages/review_tranfer.dart';
//
// class EnterAmountScreen extends StatefulWidget {
//   final String name;
//   final String phone;
//
//   const EnterAmountScreen({
//     Key? key,
//     required this.name,
//     required this.phone,
//   }) : super(key: key);
//
//   @override
//   State<EnterAmountScreen> createState() => _EnterAmountScreenState();
// }
//
// class _EnterAmountScreenState extends State<EnterAmountScreen> {
//   final _amountController = TextEditingController();
//   final _messageController = TextEditingController();
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
//         title: const Text(
//           'Enter amount',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info_outline, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   children: [
//                     // Avatar with verified badge
//                     Stack(
//                       children: [
//                         CircleAvatar(
//                           radius: 35,
//                           backgroundColor: Colors.grey[200],
//                           child: Text(
//                             widget.name[0].toUpperCase(),
//                             style: const TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: const BoxDecoration(
//                                 color: Color(0xFF00A859),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.check,
//                                 color: Colors.white,
//                                 size: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       widget.name,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.phone,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Amount',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     TextField(
//                       controller: _amountController,
//                       keyboardType: TextInputType.number,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       decoration: InputDecoration(
//                         prefixText: 'PKR ',
//                         prefixStyle: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey[600],
//                           fontWeight: FontWeight.w500,
//                         ),
//                         suffixIcon: _amountController.text.isNotEmpty
//                             ? IconButton(
//                           icon: const Icon(Icons.close, size: 20),
//                           onPressed: () {
//                             setState(() {
//                               _amountController.clear();
//                             });
//                           },
//                         )
//                             : null,
//                         filled: true,
//                         fillColor: Colors.grey[50],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             color: Colors.grey[300]!,
//                             width: 1.5,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             color: Colors.grey[300]!,
//                             width: 1.5,
//                           ),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                             color: Color(0xFF00A859),
//                             width: 2,
//                           ),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 16,
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {});
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message for ${widget.name}',
//                         hintStyle: TextStyle(
//                           color: Colors.grey[400],
//                           fontSize: 15,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Bottom section - fixed at bottom
//             Container(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFF004D3D),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Icon(
//                           Icons.shield_outlined,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Text(
//                           'Instant, reliable and secure fund transfers',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 54,
//                     child: ElevatedButton(
//                       onPressed: _amountController.text.trim().isNotEmpty
//                           ? () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ReviewTransferScreen(
//                               name: widget.name,
//                               phone: widget.phone,
//                               amount: _amountController.text,
//                             ),
//                           ),
//                         );
//                       }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF00A859),
//                         disabledBackgroundColor: Colors.grey[300],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: Text(
//                         'Continue',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: _amountController.text.trim().isNotEmpty
//                               ? Colors.white
//                               : Colors.grey[500],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
// }
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:suprapp/app/features/supr_pay/pages/review_tranfer.dart';
// //
// // class EnterAmountScreen extends StatefulWidget {
// //   final String name;
// //   final String phone;
// //
// //   const EnterAmountScreen({
// //     Key? key,
// //     required this.name,
// //     required this.phone,
// //   }) : super(key: key);
// //
// //   @override
// //   State<EnterAmountScreen> createState() => _EnterAmountScreenState();
// // }
// //
// // class _EnterAmountScreenState extends State<EnterAmountScreen> {
// //   final _amountController = TextEditingController(); // Empty by default
// //   final _messageController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         title: const Text('Enter amount'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.info_outline),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView( // Added SingleChildScrollView
// //           padding: const EdgeInsets.all(24.0),
// //           child: Column(
// //             children: [
// //               CircleAvatar(
// //                 radius: 30,
// //                 backgroundColor: Colors.grey[300],
// //                 child: Text(
// //                   widget.name[0],
// //                   style: const TextStyle(
// //                     fontSize: 24,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black54,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 12),
// //               Text(
// //                 widget.name,
// //                 style: const TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               const SizedBox(height: 4),
// //               Text(
// //                 widget.phone,
// //                 style: const TextStyle(
// //                   fontSize: 14,
// //                   color: Colors.black54,
// //                 ),
// //               ),
// //               const SizedBox(height: 32),
// //               const Align(
// //                 alignment: Alignment.centerLeft,
// //                 child: Text(
// //                   'Amount',
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 8),
// //               TextField(
// //                 controller: _amountController,
// //                 keyboardType: TextInputType.number,
// //                 style: const TextStyle(fontSize: 18),
// //                 decoration: InputDecoration(
// //                   prefixText: 'PKR ',
// //                   prefixStyle: const TextStyle(fontSize: 18),
// //                   suffixIcon: IconButton(
// //                     icon: const Icon(Icons.close),
// //                     onPressed: () => _amountController.clear(),
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                     borderSide: const BorderSide(width: 2),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 24),
// //               TextField(
// //                 controller: _messageController,
// //                 decoration: InputDecoration(
// //                   hintText: 'Type a message for ${widget.name}',
// //                   border: InputBorder.none,
// //                 ),
// //               ),
// //               const SizedBox(height: 40), // Reduced space instead of Spacer
// //               Row(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(8),
// //                     decoration: BoxDecoration(
// //                       color: const Color(0xFF004D3D),
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                     child: const Icon(
// //                       Icons.shield,
// //                       color: Colors.white,
// //                       size: 20,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   const Expanded(
// //                     child: Text(
// //                       'Instant, reliable and secure fund transfers',
// //                       style: TextStyle(fontSize: 12),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 16),
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 56,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     // Add validation to ensure amount is not empty
// //                     if (_amountController.text.trim().isNotEmpty) {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => ReviewTransferScreen(
// //                             name: widget.name,
// //                             phone: widget.phone,
// //                             amount: _amountController.text,
// //                           ),
// //                         ),
// //                       );
// //                     }
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: const Color(0xFF00A859),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     'Continue',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w600,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16), // Added bottom padding for safety
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //