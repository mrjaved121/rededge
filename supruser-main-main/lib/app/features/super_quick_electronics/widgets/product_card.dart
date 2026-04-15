import 'package:flutter/material.dart';
import 'package:suprapp/app/core/utils/responsive_utils.dart';
// ⚠ ProductDetailScreen کو صحیح جگہ سے Import کریں
// میں نے فرض کیا ہے کہ یہ اسی طرح ہے جیسے پہلے Grid View میں تھا
import '../product_detail_Screen.dart';
import '../models/product_model.dart';
import '../tabs/phome_tab.dart';

class ProductCard extends StatelessWidget {
  // 🚀 'product' کی جگہ 'item' استعمال کیا گیا ہے
  final ProductModel item;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.item, // 🚀 Constructor میں بھی 'item'
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = ResponsiveUtils.getCardWidth(context, baseWidth: 140);

    return GestureDetector(
      // 🚀 یہ اہم تبدیلی ہے: onTap میں براہ راست Navigation Logic شامل کریں
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              // ProductModel سے تمام required Strings بھیجیں:
              productImage: item.image, // 🚀 item.image
              productName: item.title,  // 🚀 item.title
              // Description کے لیے title استعمال کریں یا صحیح field دیں
              /* productDescription: item.title,*/
              price: item.discountedPrice,
              originalPrice: item.originalPrice,
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.only(right: ResponsiveUtils.wp(context, 0.1)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: ResponsiveUtils.hp(context, 13.9),
                  width: ResponsiveUtils.hp(context, 15.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Image.asset(
                      item.image, // 🚀 item.image
                      height: ResponsiveUtils.hp(context, 10.5),
                    ),
                  ),
                ),
                if (item.discount != null) // 🚀 item.discount
                  Positioned(
                    top: ResponsiveUtils.hp(context, 0.75),
                    left: ResponsiveUtils.wp(context, 1.6),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(context, 1.9),
                        vertical: ResponsiveUtils.hp(context, 0.5),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE91E63),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.discount!, // 🚀 item.discount!
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.sp(context, 10),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: ResponsiveUtils.hp(context, 0.75),
                  right: ResponsiveUtils.wp(context, 3.4),
                  child: GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      height: ResponsiveUtils.hp(context, 3.7),
                      width: ResponsiveUtils.hp(context, 3.7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300,width: 1,),
                      ),
                      child: Icon(
                        Icons.add,
                        size: ResponsiveUtils.sp(context, 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2,),
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(context, 2.1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title, // 🚀 item.title
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 11),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveUtils.hp(context, 0.5)),
                  if (item.originalPrice != null) ...[ // 🚀 item.originalPrice
                    Text(
                      item.originalPrice!, // 🚀 item.originalPrice!
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 10),
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.hp(context, 0.25)),
                  ],
                  Text(
                    item.discountedPrice, // 🚀 item.discountedPrice
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 13),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE91E63),
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
}

// Apple Product Card
class AppleProductCard extends StatelessWidget {
  final ProductModel item;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const AppleProductCard({
    super.key,
    required this.item,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = ResponsiveUtils.getCardWidth(context, baseWidth: 150);

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productImage: item.image,
              productName: item.title,
              /*  productDescription: item.title, */// Assuming product.title is used as description
              price: item.discountedPrice,
              originalPrice: item.originalPrice,
              discount: item.discount,


            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.only(right: ResponsiveUtils.wp(context, 3.2)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: ResponsiveUtils.hp(context, 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400.withOpacity(0.2),
                    borderRadius:  BorderRadius.all(Radius.circular(8)
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      item.image,
                      height: ResponsiveUtils.hp(context, 12.3),
                    ),
                  ),
                ),
                if (item.discount != null)
                  Positioned(
                    top: ResponsiveUtils.hp(context, 0.75),
                    left: ResponsiveUtils.wp(context, 1.6),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(context, 2.1),
                        vertical: ResponsiveUtils.hp(context, 0.5),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE91E63),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.discount!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.sp(context, 10),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: ResponsiveUtils.hp(context, 0.75),
                  right: ResponsiveUtils.wp(context, 3.5),
                  child: GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      height: ResponsiveUtils.hp(context, 3.7),
                      width: ResponsiveUtils.hp(context, 3.7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300,width: 1,),
                        /*boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],*/
                      ),
                      child: Icon(
                        Icons.add,
                        size: ResponsiveUtils.sp(context, 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(context, 2.1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 11),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveUtils.hp(context, 0.5)),
                  if (item.originalPrice != null)
                    Text(
                      item.originalPrice!,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.sp(context, 10),
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  SizedBox(height: ResponsiveUtils.hp(context, 0.25)),
                  Text(
                    item.discountedPrice,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(context, 13),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE91E63),
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
}