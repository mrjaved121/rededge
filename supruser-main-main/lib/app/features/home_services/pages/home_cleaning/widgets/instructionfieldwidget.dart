import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_utils.dart';

class InstructionsFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final int maxLength;

  const InstructionsFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.maxLength = 150, // Default limit 150 chars
  });

  @override
  State<InstructionsFieldWidget> createState() => _InstructionsFieldWidgetState();
}

class _InstructionsFieldWidgetState extends State<InstructionsFieldWidget> {
  late TextEditingController _controller;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() {
        _charCount = _controller.text.length;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          "Any instructions or special requirements?",
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 15),
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),

        SizedBox(height: ResponsiveUtils.getSpacing(context, 16)),

        /// Text Field with counter below
        Stack(
          children: [
            /// Main Text Field
            TextField(
              controller: _controller,
              maxLines: 4,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                counterText: "", // 🔹 Hide default counter
                hintText: "Example: Key under the mat, ironing, window",
                hintStyle: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 14),
                  color: Colors.black.withOpacity(0.6),
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.all(
                  ResponsiveUtils.getSpacing(context, 12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12),
                  ),
                  borderSide: BorderSide(color: AppColors.appGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12),
                  ),
                  borderSide: BorderSide(color: AppColors.appGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.getBorderRadius(context, 12),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.darkGreens,
                    width: 1,
                  ),
                ),
              ),
            ),

            /// Character counter (bottom right corner)
            Positioned(
              bottom: ResponsiveUtils.getSpacing(context, 8),
              right: ResponsiveUtils.getSpacing(context, 12),
              child: Text(
                "${_charCount}/${widget.maxLength}",
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(context, 12),
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
