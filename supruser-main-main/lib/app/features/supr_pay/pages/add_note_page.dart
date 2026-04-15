import 'package:flutter/material.dart';
import 'package:suprapp/app/core/constants/global_variables.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _noteController = TextEditingController();
  final int maxLength = 120;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          'Add a note',
          style: textTheme(context).titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: TextField(
                      controller: _noteController,
                      maxLength: maxLength,
                      maxLines: 6,
                      style: textTheme(context).bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: textTheme(context).bodyLarge?.copyWith(
                          color: const Color(0xFFBDBDBD),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                        counterText: '',
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Character counter
                  Text(
                    '${maxLength - _noteController.text.length} characters remaining',
                    style: textTheme(context).bodySmall?.copyWith(
                      color: const Color(0xFF999999),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Enter your text above',
                  style: textTheme(context).bodyMedium?.copyWith(
                    color: const Color(0xFFBDBDBD),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),

                // Done button (can add functionality)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _noteController.text.isNotEmpty
                        ? () {
                      Navigator.pop(context, _noteController.text);
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _noteController.text.isNotEmpty
                          ? const Color(0xFF00B8A9)
                          : const Color(0xFFE0E0E0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      disabledBackgroundColor: const Color(0xFFE0E0E0),
                      disabledForegroundColor: const Color(0xFF999999),
                    ),
                    child: Text(
                      'Done',
                      style: textTheme(context).titleMedium?.copyWith(
                        color: _noteController.text.isNotEmpty
                            ? Colors.white
                            : const Color(0xFF999999),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}