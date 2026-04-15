import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/features/dine_out/controller/offer_controller.dart';
import 'package:suprapp/app/features/dine_out/model/offer_model.dart';
import 'package:suprapp/app/features/dine_out/widgets/custom_bottomsheett_subscription.dart';
import 'package:suprapp/app/features/profile/widgets/custom_arrow_back.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});
  void showSubscriptionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SubscriptionBottomSheet(
        onSubscribe: () {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Subscribed to Careem Plus!')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text(
          "Supr Plus Offers",
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recomendation",
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Consumer<OfferProvider>(
                builder: (context, provider, _) {
                  const injectedIndex = 1;
                  final totalItems = offers.length + 1;

                  return ListView.builder(
                    itemCount: totalItems,
                    itemBuilder: (context, index) {
                      if (index == injectedIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text("All Offers",
                              style: textTheme(context)
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        );
                      }
                      final offerIndex =
                          index > injectedIndex ? index - 1 : index;
                      final offer = offers[offerIndex];
                      final selected = provider.selectedOffer == offer;

                      return Card(
                        child: ListTile(
                          leading: Image.asset(offer.image, width: 40),
                          title: Text(
                            offer.title,
                            style: textTheme(context)
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: offer.subtitle.isNotEmpty
                              ? Text(offer.subtitle,
                                  style: textTheme(context).labelLarge)
                              : null,
                          trailing: Radio<Offer>(
                            value: offer,
                            groupValue: provider.selectedOffer,
                            onChanged: (_) => provider.selectOffer(offer),
                          ),
                          onTap: () => provider.selectOffer(offer),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            CustomElevatedButton(
              text: "Subscribe now",
              onPressed: () {
                final selected = context.read<OfferProvider>().selectedOffer;
                if (selected != null) {
                  showSubscriptionSheet(context);
                }
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
