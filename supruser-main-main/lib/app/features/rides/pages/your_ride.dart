    import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

import 'package:suprapp/app/features/rides/widgets/arrow_back_leading.dart';
import 'package:suprapp/app/routes/go_router.dart';

class YourRideScreen extends StatefulWidget {
  const YourRideScreen({super.key});

  @override
  State<YourRideScreen> createState() => _YourRideScreenState();
}

class _YourRideScreenState extends State<YourRideScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CustomLeading(
            onTap: () {
              context.pop();
            },
          ),
          title: Text(
            "Your Ride",
            style: textTheme(context)
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight - 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  indicatorColor: Colors.teal,
                  dividerColor: Colors.white,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  tabs: const [
                    Tab(text: 'Scheduled'),
                    Tab(text: 'History'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "27 May, 2:40 AM - 2:50 AM",
                    style: textTheme(context)
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.radio_button_checked,
                              color: Colors.green),
                          Container(
                            width: 2,
                            height: 20,
                            color: Colors.grey[300],
                          ),
                          const Icon(Icons.radio_button_checked,
                              color: Colors.green),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRoute.manageRide);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "any random address if ",
                                style: textTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "another random address here what you want",
                                style: textTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        "https://img.freepik.com/premium-vector/ecostructure-logo-design-merging-plant-elements-with-architectural-building_579306-41549.jpg",
                        height: 130,
                        width: 130,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Hmm...",
                    style: textTheme(context)
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Looks like you havaen't taken a ride yet.",
                    textAlign: TextAlign.center,
                    style: textTheme(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text("Let's make history togather",
                      textAlign: TextAlign.center,
                      style: textTheme(context).bodyLarge),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Book a Super",
                      style: textTheme(context)
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
