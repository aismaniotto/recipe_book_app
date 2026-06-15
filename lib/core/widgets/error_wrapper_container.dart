import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/theme/color_set.dart';

class ErrorWrapperContainer extends StatelessWidget {
  final bool hasError;
  final String? errorText;
  final Widget child;

  const ErrorWrapperContainer({
    super.key,
    required this.hasError,
    this.errorText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: hasError
              ? BoxDecoration(
                  border: Border.all(color: ColorSet.error, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: child,
        ),
        if (hasError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Text(
              errorText!,
              style: TextStyle(color: ColorSet.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
