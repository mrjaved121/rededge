import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/food/widgets/filter_bottom_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';

class OffersTabsPage extends StatefulWidget {
  const OffersTabsPage({super.key});

  @override
  State<OffersTabsPage> createState() => _OffersTabsPageState();
}

class _OffersTabsPageState extends State<OffersTabsPage>
    with SingleTickerProviderStateMixin {
  final List<String> tabs = ['Top Rated', 'Offers', 'Free Delivery'];

  late TabController _tabController;

  final List<Map<String, String>> restaurants = [
    {
      'name': "McDonald's Burger",
      'rating': '4.5',
      'time': '25 - 35 mins',
      'offer': '30% off on select items',
      'image':
          'https://rs-menus-api.roocdn.com/images/69294ced-c554-4604-b48d-27536541a716/image.jpeg?width=1200&height=630&fit=crop',
    },
    {
      'name': 'Beirut',
      'rating': '4.3',
      'time': '35 - 45 mins',
      'offer': '30% off on select items',
      'image':
          'https://static.wixstatic.com/media/f16f3a_dd1deb7cd4034add938941c379e3326c~mv2.jpg/v1/fit/w_2500,h_1330,al_c/f16f3a_dd1deb7cd4034add938941c379e3326c~mv2.jpg',
    },
    {
      'name': 'Nan Chicken Tikka',
      'rating': '4.5',
      'time': '35 - 45 mins',
      'offer': '20% off',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIg2RnhhVw7HntCGYnAddAShyUsCGdK6gZyA&s',
    },
    {
      'name': 'Shawarma',
      'rating': '4.3',
      'time': '25 - 35 mins',
      'offer': '30% off crowd favourites',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcfRmoaSh95vgpDb2H7UTrLG6U8hDTkJKKbg&s',
    },
    {
      'name': 'Chaat ',
      'rating': '4.6',
      'time': '35 - 45 mins',
      'offer': '30% off on select items',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXfzXO00A1CjKVhbh6xZ17R_V0Jne-zzXZug&s',
    },
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => context.pop(),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appGrey),
                    borderRadius: BorderRadius.circular(7)),
                child: const Icon(Icons.arrow_back,
                    size: 20, color: AppColors.darkGrey),
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      color: colorScheme(context).primary,
                      border: Border.all(color: AppColors.appGrey),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Icon(Icons.menu,
                      color: Color.fromARGB(255, 20, 188, 96), size: 15),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _openFilterSheet(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Icons.filter_alt_outlined, size: 16),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabs: List.generate(tabs.length, (index) {
                        return Tab(
                          child: AnimatedBuilder(
                            animation: _tabController.animation!,
                            builder: (context, _) {
                              final isSelected = _tabController.index == index;
                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green.shade800
                                      : Colors.white,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.green.shade800
                                        : Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  tabs[index],
                                  style: textTheme(context).bodyLarge?.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Restaurants",
                style: textTheme(context)
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                '1714 Restaurants',
                style: textTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme(context).onSurface),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: tabs.map((tab) {
                    return ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  restaurant['image']!,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      restaurant['name']!,
                                      style: textTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: colorScheme(context)
                                                  .onSurface),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.green, size: 16),
                                        Text(
                                          ' ${restaurant['rating']} ',
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: colorScheme(context)
                                                      .primary),
                                        ),
                                        Text(
                                          '(999+)',
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: colorScheme(context)
                                                      .primary),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          restaurant['time']!,
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: colorScheme(context)
                                                      .onSurface),
                                        ),
                                      ],
                                    ),
                                    if (restaurant['offer']!.isNotEmpty) ...[
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          restaurant['offer']!,
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: colorScheme(context)
                                                      .surface),
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
