import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:suprapp/app/features/shops/models/shop_products_model.dart';
import 'package:suprapp/app/features/shops/pages/product_detail_screen.dart';

class ProductsPage extends StatefulWidget {
  final String specId;
  final String shopid;
  const ProductsPage({super.key, required this.specId, required this.shopid});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Future<List<ShopProductsModel>> fetchProducts(String shopId) async {
    context.loaderOverlay.show();

    final snapshot = await FirebaseFirestore.instance
        .collection('Shops')
        .doc(widget.shopid)
        .collection('Spec Shops')
        .doc(widget.specId)
        .collection('Products')
        .get();
    context.loaderOverlay.hide();

    return snapshot.docs.map((doc) {
      return ShopProductsModel.fromMap(doc.data());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchProducts(widget.specId);
    print(widget.specId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(4),
            child: const Icon(Icons.close, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
            ;
          },
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Supr',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF156856),
                ),
              ),
              TextSpan(
                text: 'Fresh',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2ECC71),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF156856),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.menu, color: Colors.white),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search item',
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.tune, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ShopProductsModel>>(
              future: fetchProducts(widget.specId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());

                if (snapshot.hasError)
                  return Center(child: Text('Error loading products'));

                if (!snapshot.hasData || snapshot.data!.isEmpty)
                  return Center(child: Text('No products found'));

                final products = snapshot.data!;

                return GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                  padding: const EdgeInsets.all(12),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,
                  children: products.map((item) {
                    return ProductsCard(
                      name: item.productName,
                      price: '₹${item.price}',
                      weight: item.amount,
                      image: item.productImage,
                      oldPrice: '₹${(item.price * 1.2).toInt()}',
                      onCardTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(
                            shopProductsModel: item,
                          ),
                        ));
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductsCard extends StatelessWidget {
  final String name;
  final String price;
  final String weight;
  final String image;
  final String oldPrice;
  final VoidCallback? onCardTap;
  final VoidCallback? onAddTap;

  const ProductsCard({
    Key? key,
    required this.name,
    required this.price,
    required this.weight,
    required this.image,
    required this.oldPrice,
    this.onCardTap,
    this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: 'product-image-$name',
                    child: Image.network(image, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              child: Text(
                weight,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const TextSpan(text: '  '),
                        TextSpan(
                          text: oldPrice,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   onTap: onAddTap,
                  //   borderRadius: BorderRadius.circular(4),
                  //   child: Card(
                  //     elevation: 1,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(4),
                  //       side: BorderSide(color: Colors.grey[300]!),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(4),
                  //       child: Icon(Icons.add, size: 16, color: Colors.black),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
