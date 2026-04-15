import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:suprapp/app/features/groceries/models/item_model.dart';
import 'package:suprapp/app/features/groceries/models/product_model.dart';
import 'package:suprapp/app/features/groceries/widgets/category_item.dart';
import 'package:suprapp/app/features/groceries/widgets/large_image_listview.dart';
import 'package:suprapp/app/features/groceries/widgets/product_section.dart';

class FreshTab extends StatefulWidget {
  const FreshTab({super.key});

  @override
  State<FreshTab> createState() => _FreshTabState();
}

class _FreshTabState extends State<FreshTab> {
  final categories = [
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C1',
            price: '21.0',
            name: 'Apple',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ868djAR5mIlAFnnjF---4paarCg48aQTr-g&s',
          ),
          ProductItem(
            id: 'C2',
            price: '4.54',
            name: 'Banana',
            imageUrl:
                'https://brightsidempls.org/cdn/shop/articles/Bananas.jpg?v=1646435008',
          ),
        ],
        title: 'Fruits',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/415/415733.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C3',
            price: '5.20',
            name: 'Tomato',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSn_RpV_Nq_aND67ekZG9sOso6gv4AQatx2sw&s',
          ),
          ProductItem(
            id: 'C4',
            price: '11.20',
            name: 'Cucumber',
            imageUrl:
                'https://aarp.widen.net/content/pfnkunhcxa/jpeg/GettyImages-1247537880-web.jpg?crop=true&anchor=7,89&q=80&color=ffffffff&u=k2e9ec&w=2033&h=1168',
          ),
        ],
        title: 'Vegetables',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3082/3082061.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C5',
            price: '11.0',
            name: 'Milk',
            imageUrl:
                'https://nutritionsource.hsph.harvard.edu/wp-content/uploads/2024/11/AdobeStock_354060824-1024x683.jpeg',
          ),
          ProductItem(
            id: 'C6',
            price: '34.30',
            name: 'Cheese',
            imageUrl:
                'https://freshbasket.com.pk/cdn/shop/articles/mozerrila_cheese_1200x.jpg?v=1724161655',
          ),
        ],
        title: 'Dairy',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/1046/1046857.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C7',
            price: '12.40',
            name: 'Bread',
            imageUrl:
                'https://www.allrecipes.com/thmb/CjzJwg2pACUzGODdxJL1BJDRx9Y=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/6788-amish-white-bread-DDMFS-4x3-6faa1e552bdb4f6eabdd7791e59b3c84.jpg',
          ),
          ProductItem(
            id: 'C8',
            price: '41.0',
            name: 'Croissant',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdA3CHk8pbUGla_Ls2INRotqW5782cFI5NCg&s',
          ),
        ],
        title: 'Bakery',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/135/135620.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C9',
            price: '81.30',
            name: 'Chicken',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaqk0g2bvO8exnqTfBltocAgnJXQ-xQMyPOw&s',
          ),
          ProductItem(
            id: 'C10',
            price: '121.50',
            name: 'Beef',
            imageUrl:
                'https://cdn.britannica.com/68/143268-050-917048EA/Beef-loin.jpg',
          ),
        ],
        title: 'Meat',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3174/3174880.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C11',
            price: '221.0',
            name: 'Fish',
            imageUrl:
                'https://vuniversity.in/wp-content/uploads/2023/10/Cuts-of-fish.png',
          ),
          ProductItem(
            id: 'C12',
            price: '51.0',
            name: 'Shrimp',
            imageUrl:
                'https://images.contentstack.io/v3/assets/bltcedd8dbd5891265b/bltce5a9e408e6073dc/664cbe3c0ba2f9ea1c043454/difference-between-shrimp-and-prawns-boiled-prawns.jpg',
          ),
        ],
        title: 'Seafood',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/831/831682.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C13',
            price: '9.50',
            name: 'Chips',
            imageUrl:
                'https://www.allrecipes.com/thmb/WyCC-RL8cuAEKfYHsdnzqi64iTc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/73135-homestyle-potato-chips-ddmfs-0348-3x4-hero-c21021303c8849bbb40c1007bfa9af6e.jpg',
          ),
          ProductItem(
            id: 'C14',
            price: '17.0',
            name: 'Cookies',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO-rNNhDnBfqG0WNIeEmcDwrLMbGDjIGIVMg&s',
          ),
        ],
        title: 'Snacks',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/857/857681.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C15',
            price: '100.0',
            name: 'Frozen Pizza',
            imageUrl:
                'https://cdn.thewirecutter.com/wp-content/media/2024/05/frozen-pizza-2048px-8979.jpg',
          ),
          ProductItem(
            id: 'C16',
            price: '29.50',
            name: 'Frozen Fries',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcf_jFEFM8--oTpG__Xavjd7kO1IRv28e_Rg&s',
          ),
        ],
        title: 'Frozen Foods',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/650/650195.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C17',
            price: '5.0',
            name: 'Juice',
            imageUrl:
                'https://cdn.healthyrecipes101.com/recipes/images/juices/orange-juice-apple-cider-vinegar-honey-recipe-clavzz7uu001z551b961w6b6a.webp',
          ),
          ProductItem(
            id: 'C18',
            price: '11.0',
            name: 'Energy Drink',
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVC0XW9pAXhyIQ_L4OD_GqcOFw-GQHFlp2pQ&s',
          ),
        ],
        title: 'Beverages',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2738/2738730.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C19',
            price: '29.0',
            name: 'Coke',
            imageUrl:
                'https://kentstreetcellars.com.au/cdn/shop/files/coke-can_7bf866c9-bffc-449d-a173-de324ac47905_1000x1000.png?v=1687840069',
          ),
          ProductItem(
            id: 'C20',
            price: '20.0',
            name: 'Pepsi',
            imageUrl:
                'https://contact.pepsico.com/files/pepsi/documents/1701962330/pepsi_lineup.jpg',
          ),
        ],
        title: 'Soft Drinks',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png'),
    const CategoryItem(
        products: [
          ProductItem(
            id: 'C21',
            price: '2.0',
            name: 'Mineral Water',
            imageUrl:
                'https://livpure.com/cdn/shop/articles/List-of-Factors-to-Take-Into-Account-When-Buying-a-Water-Purifier-1_981aaa83-c91d-4417-bfe4-e8af5032c2b2-563825.png?v=1726726245&width=1100',
          ),
          ProductItem(
            id: 'C22',
            price: '22.0',
            name: 'Sparkling Water',
            imageUrl:
                'https://blog.myfitnesspal.com/wp-content/uploads/2018/07/Is-Flavored-Sparkling-Water-Killing-Your-Weight-Loss-Goals_-1.jpg',
          ),
        ],
        title: 'Water',
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3314/3314492.png'),
    // const CategoryItem(
    //     products: [
    //       ProductItem(
    //         name: 'Tea',
    //         imageUrl:
    //             'https://ikneadtoeat.com/wp-content/uploads/2019/01/Masala-Chai-Recipe-1.jpg',
    //       ),
    //       ProductItem(
    //         name: 'Coffee',
    //         imageUrl:
    //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUiVuTP47Bb1z0h4XDC2y3a9aNkfW5jyP9FQ&s',
    //       ),
    //     ],
    //     title: 'Tea & Coffee',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/1977/1977453.png'),
    // const CategoryItem(
    //     products: [
    //       ProductItem(
    //         name: 'Corn Flakes',
    //         imageUrl:
    //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTypD6X2NlWn2EmpAs-cnveK7ffbHhAB1892w&s',
    //       ),
    //     ],
    //     title: 'Breakfast & Cereals',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/1631/1631441.png'),
    // const CategoryItem(
    //     products: [
    //       // Cooking Oils
    //       ProductItem(
    //         name: 'Sunflower Oil',
    //         imageUrl:
    //             'https://www.corolilife.com/wp-content/uploads/2020/01/Benefits-of-Sunflower-Oil.jpg',
    //       ),
    //     ],
    //     title: 'Cooking Oils',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/2474/2474440.png'),
    // const CategoryItem(
    //     products: [
    //       ProductItem(
    //         name: 'Red Chili Powder',
    //         imageUrl:
    //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbq086BO1PG1-SAxux1-MTniIWd3bxCli2MQ&s',
    //       ),
    //     ],
    //     title: 'Spices & Condiments',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075973.png'),
    // const CategoryItem(
    //     products: [
    //       // Pasta & Noodles
    //       ProductItem(
    //         name: 'Instant Noodles',
    //         imageUrl:
    //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVPvcZIxeA9bZukK18CymY32OqFUTVbkKXgQ&s',
    //       ),
    //     ],
    //     title: 'Pasta & Noodles',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/971/971091.png'),
    // const CategoryItem(
    //     products: [
    //       ProductItem(
    //         name: 'Basmati Rice',
    //         imageUrl:
    //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGiFys8TeHwEk-N0XnO20P6s1tvMUuIeyOIQ&s',
    //       ),
    //     ],
    //     title: 'Rice & Grains',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/2829/2829720.png'),
    // const CategoryItem(
    //     products: [
    //       // Canned Foods
    //       ProductItem(
    //         name: 'Canned Beans',
    //         imageUrl:
    //             '        https://www.mirchimasalay.com/cdn/shop/collections/canned-food_92298cf2-fd80-48d0-86b2-c2cc9cf40be2_1024x.jpg?v=1588670017',
    //       ),
    //     ],
    //     title: 'Canned Foods',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/650/650202.png'),
    // const CategoryItem(
    //     products: [
    //       ProductItem(
    //         name: 'Milk Chocolate Bar',
    //         imageUrl:
    //             'https://cdn-icons-png.flaticon.com/512/3217/3217699.png',
    //       ),
    //     ],
    //     title: 'Chocolates',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/2036/2036542.png'),
    // const CategoryItem(
    //     products: [],
    //     title: 'Ice Cream',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/3132/3132693.png'),
    // const CategoryItem(
    //     products: [],
    //     title: 'Baby Food',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/4474/4474269.png'),
    // const CategoryItem(
    //     products: [],
    //     title: 'Pet Supplies',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/616/616408.png'),
    // const CategoryItem(
    //     products: [],
    //     title: 'Cleaning Supplies',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/1686/1686341.png'),
    // const CategoryItem(
    //     products: [],
    //     title: 'Laundry',
    //     imageUrl: 'https://cdn-icons-png.flaticon.com/512/3075/3075974.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS58UjdeXSf8qTPnnLReA5uwCJX-yUPJlYT-A&s',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Explore Top Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            CategoryGrid(
                tileColor: Colors.grey.shade100, categories: categories),
            const SizedBox(
              height: 20,
            ),
            ProductSection(
              title: 'just in: The freshest picks',
              products: myherbalList,
              isHerbal: true,
              onSectionTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            ProductSection(
              title: 'Mango mania',
              products: mangoes,
              isHerbal: true,
              onSectionTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 250,
              child: LargeImageList(
                imageUrls: [
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4wLwuKvj91NAUFxMMxJQKZd1xXAW3IiVKIA&s"
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDh6RmUj-ZuZw_77mK_iQzGxg1R46_hVjSxg&s',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx4-Qqf3BAjIrjlA1EMzZI1WdChhJpOOLzJw&s',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV9ISghVXxkHXN2N6skyJF8sCuQSP4bd3aiw&s',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL24eDnrVQ_XWzldg-prfJnmWMzDv790aMzg&s',
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ProductSection(
              title: 'Most Loved',
              products: mostLoved,
              isHerbal: true,
              onSectionTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
