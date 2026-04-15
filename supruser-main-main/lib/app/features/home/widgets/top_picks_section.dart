import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class TopPicksSection extends StatelessWidget {
  TopPicksSection({super.key});
  final List<Map<String, String>> restaurants = [
    {
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/McDonald%27s_square_2020.svg/960px-McDonald%27s_square_2020.svg.png",
      "name": "McDonald’s"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI5Z_v-pdGwU-eiWtUXCdElfa6_qiMYkbuBg&s",
      "name": "Papa Johns"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdoIL8ZJoQQom2s6kJGpeXHvuCmwJJjKU0tA&s",
      "name": "KFC"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRfkWHPweuC8XUvE_YlOGrXaEqYO2M0GiyivMfv9J-g5HLLmWlSKFi39C0uqu1mWEU01E&usqp=CAU",
      "name": "Texas Chicken"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return
        //  ChangeNotifierProvider(
        //     create: (_) => PopularRestaurantsProvider()
        //       ..fetchPopularRestaurants(
        //           context), // Fetch data when this widget is created
        //     child: Consumer<PopularRestaurantsProvider>(
        //         builder: (context, provider, _) {
        //       // Check if the list of popular restaurants is empty and show a loading indicator
        //       if (provider.popularRestaurants.isEmpty) {
        //         return Center(child: CircularProgressIndicator());
        //       }

        // return
        Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Picks',
                  style: textTheme(
                    context,
                  ).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff0A0C0B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () {},
                    child: _buildModernBrandCard(
                      restaurant['name']!,
                      logo: restaurant['image']!,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    // }));
  }
}

Widget _buildModernBrandCard(
  String name, {
  required String logo,
}) {
  return Container(
    width: 115,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              logo,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFC8A06),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
