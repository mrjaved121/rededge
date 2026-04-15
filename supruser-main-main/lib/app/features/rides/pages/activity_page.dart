import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/model/actitivy_model.dart';
import 'package:suprapp/app/routes/go_router.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 6,
      initialIndex: 1,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _Header(),
              _TabMenu(),
              Divider(height: 1),
              Expanded(child: _TabContent()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            "Activities",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.menu, size: 20, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class _TabMenu extends StatelessWidget {
  const _TabMenu();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: Colors.teal.shade800,
      labelColor: Colors.black,
      dividerColor: Colors.black.withOpacity(0.4),
      unselectedLabelColor: Colors.grey.shade600,
      labelStyle:
          textTheme(context).labelLarge?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          textTheme(context).labelLarge?.copyWith(fontWeight: FontWeight.bold),
      tabs: const [
        Tab(icon: Icon(Icons.grid_view, size: 20), text: "All"),
        Tab(icon: Icon(Icons.directions_car, size: 20), text: "Rides"),
        Tab(icon: Icon(Icons.fastfood, size: 20), text: "Food"),
        Tab(icon: Icon(Icons.local_grocery_store, size: 20), text: "Groceries"),
        Tab(
            icon: Icon(Icons.emoji_emotions_outlined, size: 20),
            text: "Careem Plus"),
        Tab(
            icon: Icon(Icons.account_balance_wallet_outlined, size: 20),
            text: "Pay"),
      ],
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: List.generate(
        6,
        (index) => const _RideHistoryList(),
      ),
    );
  }
}

class _RideHistoryList extends StatelessWidget {
  const _RideHistoryList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: activitylist.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const _SectionHeader(title: "Today");
        } else if (index == 4) {
          return const _SectionHeader(title: "Yesterday");
        } else {
          int dataIndex = index > 4 ? index - 2 : index - 1;
          final item = activitylist[dataIndex];
          return GestureDetector(
            onTap: () {
              context.pushNamed(AppRoute.detailcancelRidePage);
            },
            child: _RideCard(
              location: item.location,
              city: item.city,
              status: item.status,
              price: item.price,
              image: item.image,
            ),
          );
        }
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  final String location;
  final String city;
  final String status;
  final String price;
  final String image;

  const _RideCard({
    required this.location,
    required this.city,
    required this.status,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Image.asset(image, width: 50, height: 50),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ride to $location",
                    style: textTheme(context)
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text("- $city",
                    style: textTheme(context)
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text("Go Premium",
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(color: Colors.grey)),
                Text(status,
                    style: textTheme(context)
                        .bodyMedium
                        ?.copyWith(color: AppColors.carmineRed)),
              ],
            ),
          ),
          Text(price,
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
