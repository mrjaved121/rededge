import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/dine_out/controller/dine_out_provider.dart';
import 'package:suprapp/app/features/dine_out/controller/filter_controller.dart';
import 'package:suprapp/app/features/dine_out/widgets/custom_card.dart';
import 'package:suprapp/app/features/dine_out/widgets/filterwidget.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/routes/go_router.dart';

class DetailDineOut extends StatelessWidget {
  final int parentIndex;
  const DetailDineOut({super.key, required this.parentIndex});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DineOutProvider>(context);
    final nestedItem = provider.getItemByIndex(parentIndex);

    final filters = context.watch<FilterProvider>().allFilters;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            floating: false,
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
                      color: colorScheme(context).surface,
                      borderRadius: BorderRadius.circular(7)),
                  child: Icon(
                    Icons.arrow_back,
                    color: colorScheme(context).onSurface,
                    size: 20,
                  ),
                ),
              ),
            ),
            backgroundColor: colorScheme(context).onPrimary,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final isCollapsed = constraints.maxHeight <=
                    kToolbarHeight + MediaQuery.of(context).padding.top;

                return FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: isCollapsed
                      ? Text(
                          "Handpicked spots that have received",
                          style: textTheme(context)
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              nestedItem.title,
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Handpicked spots that have received a lot of love lately!",
                              style: textTheme(context).labelMedium?.copyWith(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 10, color: Colors.white),
                                Text(
                                  "15 restaurants",
                                  style: textTheme(context)
                                      .labelSmall
                                      ?.copyWith(
                                          fontSize: 7,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                  background: Image.asset(
                    nestedItem.imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              const Icon(Icons.filter_alt_outlined, size: 16),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: filters
                                  .map((f) => FilterButton(label: f))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nestedItem.anotherDiscription.length,
                      itemBuilder: (context, index) {
                        final discription =
                            nestedItem.anotherDiscription[index];
                        final List<String> imageUrls = discription.image
                            .expand((img) => [
                                  img.image1,
                                  img.image2,
                                  img.image3,
                                  img.image4,
                                  img.image5,
                                  img.image6,
                                  img.image7,
                                  img.image8,
                                ])
                            .toList();

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                              onTap: () => context.pushNamed(
                                    AppRoute.anotherpage,
                                    pathParameters: {
                                      'parentIndex': parentIndex.toString(),
                                      'childIndex': index.toString(),
                                    },
                                  ),
                              child: CustomContainer(
                                  images: imageUrls,
                                  text: "only on supr",
                                  title: discription.title,
                                  rating: discription.rating,
                                  location: discription.location,
                                  food: discription.food,
                                  discount: discription.discount)),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
