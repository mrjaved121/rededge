import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/responsive_utils.dart';

import 'add_new_contact.dart';
import 'enter_amout_page.dart';

class SelectRecipientScreen extends StatelessWidget {
  const SelectRecipientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: ResponsiveUtils.getIconSize(context, base: 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select a recipient',
          style: TextStyle(
            fontSize: ResponsiveUtils.adaptive(
              context,
              small: 18,
              medium: 20,
              large: 22,
              tablet: 24,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveUtils.wp(context, 2)),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.qr_code_scanner,
                color: Colors.black,
                size: ResponsiveUtils.getIconSize(context, base: 20),
              ),
              label: Text(
                'Scan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 14,
                    medium: 15,
                    large: 16,
                    tablet: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search name or number',
                prefixIcon: Icon(
                  Icons.search,
                  size: ResponsiveUtils.getIconSize(context, base: 20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12)
                  ),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12)
                  ),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.getSpacing(context, 12),
                  horizontal: ResponsiveUtils.getSpacing(context, 16),
                ),
                hintStyle: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 14,
                    medium: 15,
                    large: 16,
                    tablet: 17,
                  ),
                ),
              ),
              style: TextStyle(
                fontSize: ResponsiveUtils.adaptive(
                  context,
                  small: 14,
                  medium: 15,
                  large: 16,
                  tablet: 17,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.getSpacing(context, 16),
              vertical: ResponsiveUtils.getSpacing(context, 8),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Careem contacts',
                style: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 18,
                    medium: 20,
                    large: 22,
                    tablet: 24,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                _buildContactTile(
                  context,
                  'john',
                  '+92 3126678811',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterAmountScreen(
                          name: 'john',
                          phone: '+971 126678811',
                        ),
                      ),
                    );
                  },
                ),
                _buildContactTile(
                  context,
                  'hyden',
                  '+971 126678811',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterAmountScreen(
                          name: 'hyden',
                          phone: '+97 1126678811',
                        ),
                      ),
                    );
                  },
                ),
                _buildContactTile(
                  context,
                  'Azeem',
                  '+97 1004673058',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterAmountScreen(
                          name: 'Azeem',
                          phone: '+97 1004673058',
                        ),
                      ),
                    );
                  },
                ),
                _buildContactTile(
                  context,
                  'Ac ',
                  '+97 1007922478',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterAmountScreen(
                          name: 'Ac ',
                          phone: '+97 1007922478',
                        ),
                      ),
                    );
                  },
                ),
                _buildContactTile(
                  context,
                  'simon',
                  '+97 1064987934',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterAmountScreen(
                          name: 'simon',
                          phone: '+97 1064987934',
                        ),
                      ),
                    );
                  },
                ),
                _buildContactTile(
                  context,
                  'maxewell',
                  '+97 1001234567',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnterAmountScreen(
                          name: 'maxewell',
                          phone: '+97 1001234567',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewContactScreen(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(
                    double.infinity,
                    ResponsiveUtils.getButtonHeight(context, base: 56)
                ),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12)
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: ResponsiveUtils.getSpacing(context, 16)
                ),
              ),
              child: Text(
                'Add a new recipient',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 15,
                    medium: 16,
                    large: 17,
                    tablet: 18,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(
      BuildContext context,
      String name,
      String phone,
      {VoidCallback? onTap}
      ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        radius: ResponsiveUtils.getIconSize(context, base: 20),
        child: Text(
          name[0],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: ResponsiveUtils.adaptive(
              context,
              small: 14,
              medium: 15,
              large: 16,
              tablet: 17,
            ),
          ),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: ResponsiveUtils.adaptive(
            context,
            small: 15,
            medium: 16,
            large: 17,
            tablet: 18,
          ),
        ),
      ),
      subtitle: Text(
        phone,
        style: TextStyle(
          fontSize: ResponsiveUtils.adaptive(
            context,
            small: 13,
            medium: 14,
            large: 15,
            tablet: 16,
          ),
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getSpacing(context, 12),
          vertical: ResponsiveUtils.getSpacing(context, 6),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context, 16)
          ),
        ),
        child: Text(
          'On Careem',
          style: TextStyle(
            fontSize: ResponsiveUtils.adaptive(
              context,
              small: 11,
              medium: 12,
              large: 13,
              tablet: 14,
            ),
            color: Colors.black54,
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, 16),
        vertical: ResponsiveUtils.getSpacing(context, 8),
      ),
      minLeadingWidth: ResponsiveUtils.wp(context, 10),
      onTap: onTap,
    );
  }
}