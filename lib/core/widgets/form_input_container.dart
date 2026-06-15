import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/app_text_styles.dart';

class FormInputContainer extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const FormInputContainer({
    super.key,
    required this.label,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label),
          SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}
