import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_elevated_button.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class ProductDetailSheet extends StatefulWidget {
  const ProductDetailSheet({super.key});

  @override
  State<ProductDetailSheet> createState() => _ProductDetailSheetState();
}

class _ProductDetailSheetState extends State<ProductDetailSheet> {
  int quantity = 1;
  final TextEditingController _requestController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageSection(),
          _buildProductInfo(),
          _buildSpecialRequestField(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Image.asset(
            AppImages.award,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black.withOpacity(0.2))),
                child: const Icon(
                  Icons.close,
                  size: 15,
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'American Assorted 12 Pieces',
            style: textTheme(context)
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
              'Enjoy with selection of 12 pcs, 4 pieces samurai roll, 4 pieces California crispy roll, 4 pieces sweet baked roll.',
              style: textTheme(context).bodyMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'AED 30',
                style: textTheme(context)
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                'AED 60',
                style: textTheme(context).labelLarge?.copyWith(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Save 50%',
                  style: textTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequestField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.edit_document, size: 20),
            title: Text(
              'Special requests',
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Got any requests for the restaurant?',
              style: textTheme(context).labelMedium,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: _requestController,
            maxline: 4,
            fillColor: Colors.white,
            borderRadius: 5,
            hint: "For example: Less Spicy , no Sugar etc.",
            hintColor: Colors.grey,
            contentPadding: const EdgeInsets.all(10),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          _buildQuantitySelector(),
          const SizedBox(width: 16),
          SizedBox(
            width: 200,
            height: 45,
            child: CustomElevatedButton(
                text: 'Add • AED ${30 * quantity}', onPressed: () {}),
          )
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  if (quantity > 1) {
                    setState(() => quantity--);
                  }
                },
                child: const Icon(Icons.delete_outline, size: 15)),
          ),
          Text(quantity.toString(),
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  setState(() => quantity++);
                },
                child: const Icon(
                  Icons.add,
                  size: 15,
                )),
          ),
        ],
      ),
    );
  }
}
