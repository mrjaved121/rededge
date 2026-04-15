import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/app_colors.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/rides/provider/pick_up_provider.dart';

class SaveLocationPage extends StatefulWidget {
  const SaveLocationPage({super.key});

  @override
  State<SaveLocationPage> createState() => _SaveLocationPageState();
}

class _SaveLocationPageState extends State<SaveLocationPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PickupDetailsProvider>(context);
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
                Icons.close,
                color: AppColors.darkGrey,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          "Save location ",
          style: textTheme(context).displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme(context).onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 10,
              shadowColor: AppColors.appGrey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey[200],
                  height: 160,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg', // replace with Google Map or asset
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Icon(Icons.location_on,
                            size: 40, color: Colors.green),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: colorScheme(context).primary,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Container(
                                    height: 5,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: colorScheme(context).surface,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sadaf 8',
                                    style: textTheme(context)
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                colorScheme(context).onSurface),
                                  ),
                                  Text(
                                    'Dubai - United Arab Emirates',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.4)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Name your location (Home/Work etc.)',
                hintStyle: textTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme(context).onSurface.withOpacity(0.3)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              onChanged: (val) => provider.setLocationName(val),
            ),
            SizedBox(height: 24),
            TextButton.icon(
              onPressed: () {
                provider.togglePickupField();
              },
              icon: Icon(
                Icons.add,
                color: colorScheme(context).primary,
                size: 15,
              ),
              label: Text(
                'ADD OTHER DETAILS',
                style: textTheme(context).labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme(context).primary),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent),
            ),
            if (provider.showPickupField)
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Add pickup details',
                  hintStyle: textTheme(context).titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme(context).onSurface.withOpacity(0.3)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                onChanged: (val) => provider.setPickupDetails(val),
              ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: provider.isFormValid
                    ? () {
                        context.pop();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: provider.isFormValid
                        ? colorScheme(context).primary
                        : Colors.grey[200],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  'Save',
                  style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: provider.isFormValid
                            ? colorScheme(context).surface
                            : AppColors.darkGrey,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
