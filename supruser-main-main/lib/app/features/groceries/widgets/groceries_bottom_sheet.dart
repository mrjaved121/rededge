import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';
import 'package:suprapp/app/shared/widgets/custom_textformfield.dart';

class DeliveryLocationSheet extends StatelessWidget {
  DeliveryLocationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delivery Location',
              style: textTheme(context).bodyMedium?.copyWith(),
            ),
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            prefixIcon: AppIcon.searchIcon,
            hint: 'Search...',
          ),
          SizedBox(height: 20),
          _buildListTile(
            icon: Icons.location_on_outlined,
            title: 'Find on map',
            onTap: () {},
            context: context,
          ),
          _buildListTile(
            context: context,
            icon: Icons.navigation_outlined,
            title: 'Current location',
            onTap: null,
            enabled: false,
          ),
          _buildListTile(
            context: context,
            icon: Icons.add,
            title: 'Add new address',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required BuildContext context,
    required VoidCallback? onTap,
    bool enabled = true,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: enabled ? Colors.black : Colors.grey),
      title: Text(title,
          style: textTheme(context).bodyMedium?.copyWith(
                color: enabled ? Colors.black : Colors.grey,
              )),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      enabled: enabled,
    );
  }
}
