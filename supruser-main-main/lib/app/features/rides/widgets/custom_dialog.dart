import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final VoidCallback onYes;
  final VoidCallback onNo;

  const ConfirmDeleteDialog({
    super.key,
    required this.title,
    required this.onYes,
    required this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme(context).bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme(context).onSurface.withOpacity(0.4)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDE2417),
                    fixedSize: const Size(100, 20),
                  ),
                  onPressed: onNo,
                  child: Text(
                    'No',
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme(context).surface),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    fixedSize: const Size(100, 20),
                  ),
                  onPressed: onYes,
                  child: Text(
                    'Yes',
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme(context).surface),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
