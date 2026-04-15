import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/provider/selection_provider.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class SearchCityPage extends StatefulWidget {
  const SearchCityPage({super.key});

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  final search = TextEditingController();
  final List<String> items = [
    'Dubai',
    'Abu Dhabi',
    'Sharjha',
    'Al Ain',
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SelectionProvider>(context);
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
        title: Text(
          "SEARCH ",
          style: textTheme(context).titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme(context).onSurface),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: 40, // custom height(
                child: CustomTextFormField(
                  fillColor: colorScheme(context).onSurface.withOpacity(0.08),
                  hint: ' Search for a city',
                  hintSize: 16,
                  borderColor: Colors.transparent,
                  hintColor: AppColors.darkGrey,
                  prefixIcon: AppIcon.searchIcon,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '|',
                          style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.2),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Dubai", // Replace with selected country variable
                          style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.2),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color:
                              colorScheme(context).onSurface.withOpacity(0.2),
                          size: 23,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(children: [
              Container(
                height: 40,
                width: double.infinity,
                color: colorScheme(context).onSurface.withOpacity(0.08),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLS0qvyL9DV4cgo-Uc4sLIQh2lQVUQOnng9A&s',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "UAE",
                        style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.2),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    bool isSelected = provider.selectedIndex == index;
                    return ListTile(
                      onTap: () => provider.selectIndex(index),
                      leading: Text(
                        items[index],
                        style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.5),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: isSelected
                          ? Icon(Icons.done,
                              color: colorScheme(context).primary)
                          : null,
                    );
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
