import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suprapp/app/features/supr_pay/pages/supr_pay.dart';
import '../../../core/utils/responsive_utils.dart';


class MyPayLinksScreen extends StatelessWidget {
  const MyPayLinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: ResponsiveUtils.getIconSize(context, base: 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Pay links',
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: ResponsiveUtils.hp(context, 1)),
              Text(
                'Share to get paid',
                style: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 20,
                    medium: 22,
                    large: 24,
                    tablet: 26,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 12)),
              Text(
                'Be creative, share your Careem QR code or\nPay link on social media, printed stickers, or\non a tshirt.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveUtils.adaptive(
                    context,
                    small: 13,
                    medium: 14,
                    large: 15,
                    tablet: 16,
                  ),
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(context, 3)),
              // QR Code Container - Made smaller
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 20)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12)
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: ResponsiveUtils.wp(context, 45), // 45% of screen width
                      height: ResponsiveUtils.wp(context, 45), // Square aspect ratio
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(
                            ResponsiveUtils.getBorderRadius(context, 8)
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.qr_code_2,
                          size: ResponsiveUtils.wp(context, 35), // 35% of screen width
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.getSpacing(context, 15)),
                    Text(
                      'Have this QR code scanned to\nreceive touch-free payments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.adaptive(
                          context,
                          small: 13,
                          medium: 14,
                          large: 15,
                          tablet: 16,
                        ),
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),
              // Pay Link Container
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, 12)
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: ResponsiveUtils.getIconSize(context, base: 40),
                      height: ResponsiveUtils.getIconSize(context, base: 40),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8E6D5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.link,
                        color: const Color(0xFF00A859),
                        size: ResponsiveUtils.getIconSize(context, base: 20),
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.getSpacing(context, 12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your pay link',
                            style: TextStyle(
                              fontSize: ResponsiveUtils.adaptive(
                                context,
                                small: 13,
                                medium: 14,
                                large: 15,
                                tablet: 16,
                              ),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.getSpacing(context, 2)),
                          Text(
                            'https://cpay.me/9230...',
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
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Copy',
                        style: TextStyle(
                          color: const Color(0xFF00A859),
                          fontSize: ResponsiveUtils.adaptive(
                            context,
                            small: 13,
                            medium: 14,
                            large: 15,
                            tablet: 16,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(), // This will take available space
              SizedBox(height: ResponsiveUtils.getSpacing(context, 20)),
              // Share Button
              SizedBox(
                width: double.infinity,
                height: ResponsiveUtils.getButtonHeight(context, base: 50),
                child: ElevatedButton(
                  onPressed: () {
                    _showShareBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ResponsiveUtils.getBorderRadius(context, 12)
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                          Icons.share,
                          color: Colors.white,
                          size: ResponsiveUtils.getIconSize(context, base: 20)
                      ),
                      SizedBox(width: ResponsiveUtils.getSpacing(context, 8)),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontSize: ResponsiveUtils.adaptive(
                            context,
                            small: 15,
                            medium: 16,
                            large: 17,
                            tablet: 18,
                          ),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(ResponsiveUtils.getBorderRadius(context, 20))
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.only(bottom: ResponsiveUtils.getSpacing(context, 20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bottom sheet header
            Container(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Share with the world',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.adaptive(
                        context,
                        small: 16,
                        medium: 17,
                        large: 18,
                        tablet: 19,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: ResponsiveUtils.getIconSize(context, base: 24),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Share options
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.getSpacing(context, 16)),
              child: Column(
                children: [
                  // Share link option
                  ListTile(
                    leading: Container(
                      width: ResponsiveUtils.getIconSize(context, base: 40),
                      height: ResponsiveUtils.getIconSize(context, base: 40),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8E6D5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.link,
                        color: const Color(0xFF00A859),
                        size: ResponsiveUtils.getIconSize(context, base: 20),
                      ),
                    ),
                    title: Text(
                      'Share link',
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
                    trailing: Checkbox(
                      value: false,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF00A859),
                    ),
                    onTap: () {
                      // Handle share link action
                    },
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.getSpacing(context, 8)
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.getSpacing(context, 8)),
                  // Share QR option
                  ListTile(
                    leading: Container(
                      width: ResponsiveUtils.getIconSize(context, base: 40),
                      height: ResponsiveUtils.getIconSize(context, base: 40),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8E6D5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.qr_code_2,
                        color: const Color(0xFF00A859),
                        size: ResponsiveUtils.getIconSize(context, base: 20),
                      ),
                    ),
                    title: Text(
                      'Share QR',
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
                    trailing: Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: const Color(0xFF00A859),
                    ),
                    onTap: () {
                      // Handle share QR action
                    },
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.getSpacing(context, 8)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}