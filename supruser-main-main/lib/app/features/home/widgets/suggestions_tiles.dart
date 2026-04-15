import 'package:flutter/material.dart';
import 'package:suprapp/app/features/home/widgets/item_grid_suggestions.dart';

class SuggestionTile extends StatelessWidget {
  final List<Map<String, String>> suggestionsItems;

  const SuggestionTile({super.key, required this.suggestionsItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestionsItems.length,
        itemBuilder: (context, index) {
          return ItemGridTileLargeImage(
            imagePath: suggestionsItems[index]['imagePath']!,
            title: suggestionsItems[index]['title']!,
            onTap: () {
              print('Tapped on item ${suggestionsItems[index]['title']}');
            },
          );
        },
      ),
    );
  }
}
