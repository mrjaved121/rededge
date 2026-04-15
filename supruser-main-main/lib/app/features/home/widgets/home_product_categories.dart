import 'package:flutter/material.dart';
// aapke imports...
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class HomeProductCategories extends StatelessWidget {
  HomeProductCategories({super.key});

  final List<Map<String, String>> sliderItems = [
    // Sirf asset images rakhi gayi hain
    {
      'image': AppImages.creamhomebanner,
      'title': '',
    },
    {
      'image': AppImages.creamhomebanner,
      'title': '',
    },
    {
      'image': AppImages.creamhomebanner,
      'title': '',
    },
    {
      'image': AppImages.creamhomebanner,
      'title': '',
    },

  ];

  @override
  Widget build(BuildContext context) {
    // List Item ki fixed width set kar di gayi hai (aap isse adjust kar sakte hain)
    final double itemWidth = MediaQuery.of(context).size.width * 0.75;

    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- CAROUSELSLIDER KI JAGAH LISTVIEW.BUILDER ---
          SizedBox(
            height: 230,
            child: ListView.builder( // <--- Naya Widget
              itemCount: sliderItems.length,
              scrollDirection: Axis.horizontal, // Horizontal Scroll

              // Item builder mein list ke items generate kiye jaayenge
              itemBuilder: (context, index) {
                final item = sliderItems[index];

                return Container(
                  // Item ki width set ki gayi hai
                  width: 330,
                  // Margin se items ke beech gap create kiya gaya hai
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),

                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                    // Asset Image ka istemal
                    image: DecorationImage(
                      image: AssetImage(item['image']!),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                colorScheme(context).secondary.withAlpha(1,),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      // Centered Text on top of the image
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          item['title']!,
                          style: textTheme(context).titleLarge?.copyWith(
                              color: colorScheme(context).surface,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:suprapp/app/core/constants/app_colors.dart';
// import 'package:suprapp/app/core/constants/app_images.dart';
// import 'package:suprapp/app/core/constants/global_variables.dart';
//
// class HomeProductCategories extends StatelessWidget {
//   HomeProductCategories({super.key});
//
//   final List<Map<String, String>> sliderItems = [
//     {
//       'image':
//       'https://tapcom-live.ams3.cdn.digitaloceanspaces.com/media/cache/f0/a0/f0a0e2c7269e2c92eb270c41b967da47.jpg',
//       'title': '',
//     },
//     // {
//     //   'image':
//     //   'https://www.macopkg.com/wp-content/uploads/2023/02/supermarket-aisle-1536x1152.jpg',
//     //   'title': 'shop Groceries',
//     // },
//     {
//       'image':AppImages.creamhomebanner,
//       'title': '',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Popular Categories',
//             style: textTheme(
//               context,
//             ).headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold, color: const Color(0xff0A0C0B)),
//           ),
//           SizedBox(
//             height: 200,
//             child: CarouselSlider(
//               items: sliderItems.map((item) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width * 0.80,
//                   margin:
//                   const EdgeInsets.symmetric(vertical: 16, horizontal:1),
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 8,
//                         spreadRadius: 1,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(12),
//                     image: DecorationImage(
//                       image: AssetImage(item['image']!),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         bottom: 0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                               colors: [
//                                 colorScheme(context).secondary.withAlpha(
//                                   1,
//                                 ), // Fading color (black)
//                                 Colors.transparent, // Transparent at the top
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned.fill(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             /*gradient: LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               stops: const [
//                                 0.0,
//                                 0.3,
//                                 0.6,
//                                 1.0
//                               ], */// Adjusted stops for smoother transition
//                              /* colors: [
//                                 Colors.transparent,
//                                 Colors.transparent,
//                                 AppColors.accentColor.withOpacity(
//                                     ), // Lower opacity for smoother fade
//                                 AppColors.bluish.withOpacity(
//                                     0.8), // Lower opacity for smoother fade
//                               ],*/
//                             ),
//                           ),
//                         ),
//
//                       // Centered Text on top of the image
//                       Positioned(
//                         bottom: 20,
//                         left: 20,
//                         child: Text(
//                           item['title']!,
//                           style: textTheme(context).titleLarge?.copyWith(
//                               color: colorScheme(context).surface,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//               options: CarouselOptions(
//                 height: 200,
//                 aspectRatio: 14 / 9,
//                 viewportFraction: 0.85, // Changed from 0.999 to 0.85 for 80% width with peek effect
//                 initialPage: 0,
//                 enableInfiniteScroll: true,
//                 reverse: false,
//                 autoPlay: false,
//                 autoPlayInterval: const Duration(seconds: 2),
//                 autoPlayAnimationDuration: const Duration(milliseconds: 600),
//                 autoPlayCurve: Curves.linear,
//                 enlargeCenterPage: true,
//                 enlargeFactor: 0.3,
//                 onPageChanged: (index, reason) {
//                   print(index);
//                 },
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }