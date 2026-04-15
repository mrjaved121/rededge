import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/dine_out/controller/dine_out_provider.dart';
import 'package:suprapp/app/features/dine_out/pages/another_restorant.dart';
import 'package:suprapp/app/features/dine_out/pages/restaurent_detail_page.dart';
import 'package:suprapp/app/features/dine_out/widgets/custom_card.dart';
import 'package:suprapp/app/features/dine_out/widgets/filter_food.dart';
import 'package:suprapp/app/features/dine_out/widgets/restaurent_widget.dart';
import 'package:suprapp/app/features/home/widgets/top_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:suprapp/app/features/dine_out/controller/filter_controller.dart';
import 'package:suprapp/app/features/dine_out/widgets/filterwidget.dart';
import 'package:suprapp/app/features/dine_out/widgets/restaurent_card.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class DineOutPage extends StatefulWidget {
  const DineOutPage({super.key});

  @override
  State<DineOutPage> createState() => _DineOutPageState();
}

class _DineOutPageState extends State<DineOutPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> tabData = [
    {'icon': AppIcon.allIcon, 'text': 'All'},
    {'icon': AppIcon.percetIcon, 'text': 'Offers'},
    {'icon': AppIcon.starIcon, 'text': 'Buy1Get1'},
    {'icon': AppIcon.trophyIcon, 'text': 'Award Winning'},
    {'icon': AppIcon.cheersIcon, 'text': 'Cheers'},
    {'icon': AppIcon.viewIcon, 'text': 'Great Views'},
    {'icon': AppIcon.leafIcon, 'text': 'Only Veg'},
    {'icon': AppIcon.waterBottleIcon, 'text': 'Shisha'},
  ];
  final List<Map<String, dynamic>> restaurant = [
    {
      'image':
          'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=300&q=60',
      'name': 'Press\'d',
      'location': ' 4.3 . Ground Level, Polo Residence',
      'billingperperson': 'Fast Food , Burher . Avg bill: AED 100/person',
      'tag': 'Coffee & Snacks',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAXpv8jwkMAtO-0eUQZf8LiwgGYF_np8aObA&s',
      'name': 'Urban Bites',
      'location': ' 4.3 . Ground Level, Polo Residence',
      'billingperperson': 'Fast Food , Burher . Avg bill: AED 100/person',
      'tag': 'Fast Food',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdWPzgJkstd0rds9qWiBde--Dw_4sB-FdGSg&s',
      'name': 'Green Bowl',
      'location': ' 4.3 . Ground Level, Polo Residence',
      'billingperperson': 'Fast Food , Burher . Avg bill: AED 100/person',
      'tag': 'Healthy',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgXw0pqGYwHn2ieksnWU1IoVsu7TQUfvFwsQ&s',
      'name': 'Cafe Bloom',
      'location': ' 4.3 . Ground Level, Polo Residence',
      'billingperperson': 'Fast Food , Burher . Avg bill: AED 100/person',
      'tag': 'Cafe',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz12UCZeZo5yxJMx3rXcat92SbXA8LT0VVsw&s',
      'name': 'The Sizzle House',
      'location': ' 4.3 . Ground Level, Polo Residence',
      'billingperperson': 'Fast Food , Burher . Avg bill: AED 100/person',
      'tag': 'Grill',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<DineOutProvider>(context);
    final filters = context.watch<FilterProvider>().allFilters;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appGrey),
                  borderRadius: BorderRadius.circular(7)),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.darkGrey,
                size: 20,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'DineOut',
          style: textTheme(context).headlineLarge?.copyWith(
                color: colorScheme(context).primary,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                context.pushNamed(AppRoute.favouriteRestaurentPage);
              },
              child: Container(
                height: 50,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appGrey),
                    borderRadius: BorderRadius.circular(7)),
                child: const Icon(
                  Icons.favorite_outline,
                  color: AppColors.darkGrey,
                  size: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'TopSheet',
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                  transitionBuilder: (_, animation, __, ___) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: TopSheetWidget(),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: 40,
                decoration: BoxDecoration(
                    color: colorScheme(context).primary,
                    border: Border.all(color: AppColors.appGrey),
                    borderRadius: BorderRadius.circular(7)),
                child: const Icon(
                  Icons.menu,
                  color: Color.fromARGB(255, 20, 188, 96),
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(
              hint: 'Search restaurents',
              horizontalPadding: 15,
              hintSize: 16,
              hintColor: AppColors.darkGrey,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  AppIcon.searchIcon,
                  height: 10,
                  width: 10,
                  color: colorScheme(context).onSurface.withOpacity(0.6),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: AnimatedBuilder(
              animation: _tabController,
              builder: (context, _) {
                return TabBar(
                  controller: _tabController,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  dividerHeight: 2,
                  dividerColor: AppColors.appGrey,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: colorScheme(context).primary,
                    ),
                    insets: const EdgeInsets.symmetric(horizontal: 15.0),
                  ),
                  tabs: List.generate(tabData.length, (index) {
                    final isSelected = _tabController.index == index;
                    final color = isSelected ? Colors.black : Colors.grey;

                    return SizedBox(
                      height: 70,
                      width: 90,
                      child: Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              tabData[index]['icon']!,
                              height: 24,
                              width: 24,
                              color: color,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              tabData[index]['text']!,
                              style: textTheme(context).bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.filterPage);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(Icons.filter_alt_outlined, size: 16),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filters
                          .map((f) => FilterButtonsWidget(label: f))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Where  to  DineOut ?",
                              style: textTheme(context)
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              "Handpicked spots you'll want to try",
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: colorScheme(context)
                                      .onSurface
                                      .withOpacity(0.5),
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: Icon(
                              Icons.east,
                              color: Colors.black.withOpacity(0.6),
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.23,
                            width: size.width,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.items.length,
                                itemBuilder: (context, index) {
                                  final item = provider.items[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => context.pushNamed(
                                        AppRoute.detailDineOutPage,
                                        pathParameters: {
                                          'parentIndex': index.toString(),
                                        },
                                      ),
                                      child: Container(
                                        height: size.height * 0.2,
                                        width: size.width * 0.25,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage(item.imageUrl),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              item.title,
                                              style: textTheme(context)
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          colorScheme(context)
                                                              .onPrimary),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleLarge?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurant.length,
                            itemBuilder: (context, index) {
                              final item = restaurant[index];
                              final List<String> imageUrls =
                                  List.generate(8, (_) => item['image']);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurentDetailPage(
                                          childIndex: index,
                                          parentIndex: index,
                                          restaurantData: item,
                                        ),
                                      ),
                                    );
                                  },
                                  child: RestaurentWidget(
                                      images: imageUrls,
                                      text: "only on supr",
                                      title: item['name'],
                                      rating: '4.8',
                                      location: item['location'],
                                      food: item['billingperperson'],
                                      discount: item['tag']),
                                  // RestaurantCard(
                                  //   imageUrl: item['image'],
                                  //   title: item['name'],
                                  //   location: item['location'],
                                  //   price: item['billingperperson'],
                                  //   tag: item['tag'],
                                  // ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final item = restaurant[index];
                                final List<String> imageUrls =
                                    List.generate(8, (_) => item['image']);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurentDetailPage(
                                            childIndex: index,
                                            parentIndex: index,
                                            restaurantData: item,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RestaurentWidget(
                                        images: imageUrls,
                                        text: "only on supr",
                                        title: item['name'],
                                        rating: '4.8',
                                        location: item['location'],
                                        food: item['billingperperson'],
                                        discount: item['tag']),
                                    // RestaurantCard(
                                    //   imageUrl: item['image'],
                                    //   title: item['name'],
                                    //   location: item['location'],
                                    //   price: item['billingperperson'],
                                    //   tag: item['tag'],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final item = restaurant[index];
                                final List<String> imageUrls =
                                    List.generate(8, (_) => item['image']);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurentDetailPage(
                                            childIndex: index,
                                            parentIndex: index,
                                            restaurantData: item,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RestaurentWidget(
                                        images: imageUrls,
                                        text: "only on supr",
                                        title: item['name'],
                                        rating: '4.8',
                                        location: item['location'],
                                        food: item['billingperperson'],
                                        discount: item['tag']),
                                    // RestaurantCard(
                                    //   imageUrl: item['image'],
                                    //   title: item['name'],
                                    //   location: item['location'],
                                    //   price: item['billingperperson'],
                                    //   tag: item['tag'],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final item = restaurant[index];
                                final List<String> imageUrls =
                                    List.generate(8, (_) => item['image']);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurentDetailPage(
                                            childIndex: index,
                                            parentIndex: index,
                                            restaurantData: item,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RestaurentWidget(
                                        images: imageUrls,
                                        text: "only on supr",
                                        title: item['name'],
                                        rating: '4.8',
                                        location: item['location'],
                                        food: item['billingperperson'],
                                        discount: item['tag']),
                                    // RestaurantCard(
                                    //   imageUrl: item['image'],
                                    //   title: item['name'],
                                    //   location: item['location'],
                                    //   price: item['billingperperson'],
                                    //   tag: item['tag'],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final item = restaurant[index];
                                final List<String> imageUrls =
                                    List.generate(8, (_) => item['image']);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurentDetailPage(
                                            childIndex: index,
                                            parentIndex: index,
                                            restaurantData: item,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RestaurentWidget(
                                        images: imageUrls,
                                        text: "only on supr",
                                        title: item['name'],
                                        rating: '4.8',
                                        location: item['location'],
                                        food: item['billingperperson'],
                                        discount: item['tag']),
                                    // RestaurantCard(
                                    //   imageUrl: item['image'],
                                    //   title: item['name'],
                                    //   location: item['location'],
                                    //   price: item['billingperperson'],
                                    //   tag: item['tag'],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final item = restaurant[index];
                                final List<String> imageUrls =
                                    List.generate(8, (_) => item['image']);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurentDetailPage(
                                            childIndex: index,
                                            parentIndex: index,
                                            restaurantData: item,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RestaurentWidget(
                                        images: imageUrls,
                                        text: "only on supr",
                                        title: item['name'],
                                        rating: '4.8',
                                        location: item['location'],
                                        food: item['billingperperson'],
                                        discount: item['tag']),
                                    // RestaurantCard(
                                    //   imageUrl: item['image'],
                                    //   title: item['name'],
                                    //   location: item['location'],
                                    //   price: item['billingperperson'],
                                    //   tag: item['tag'],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final item = restaurant[index];
                                final List<String> imageUrls =
                                    List.generate(8, (_) => item['image']);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurentDetailPage(
                                            childIndex: index,
                                            parentIndex: index,
                                            restaurantData: item,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RestaurentWidget(
                                        images: imageUrls,
                                        text: "only on supr",
                                        title: item['name'],
                                        rating: '4.8',
                                        location: item['location'],
                                        food: item['billingperperson'],
                                        discount: item['tag']),
                                    // RestaurantCard(
                                    //   imageUrl: item['image'],
                                    //   title: item['name'],
                                    //   location: item['location'],
                                    //   price: item['billingperperson'],
                                    //   tag: item['tag'],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore dining spots',
                            style: textTheme(context).titleMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.height * 0.6,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final item = restaurant[index];
                                final List<String> imageUrls =
                                    List.generate(8, (_) => item['image']);

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurentDetailPage(
                                            childIndex: index,
                                            parentIndex: index,
                                            restaurantData: item,
                                          ),
                                        ),
                                      );
                                    },
                                    child: RestaurentWidget(
                                        images: imageUrls,
                                        text: "only on supr",
                                        title: item['name'],
                                        rating: '4.8',
                                        location: item['location'],
                                        food: item['billingperperson'],
                                        discount: item['tag']),
                                    // RestaurantCard(
                                    //   imageUrl: item['image'],
                                    //   title: item['name'],
                                    //   location: item['location'],
                                    //   price: item['billingperperson'],
                                    //   tag: item['tag'],
                                    // ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
