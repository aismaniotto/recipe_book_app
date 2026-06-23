import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_app/core/localization_generated/locale_keys.g.dart';

class NpsDialog extends StatefulWidget {
  const NpsDialog({super.key});

  @override
  State<NpsDialog> createState() => _NpsDialogState();
}

class _NpsDialogState extends State<NpsDialog> {
  int? _selectedScore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(LocaleKeys.nps_title.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.nps_question.tr()),
          const SizedBox(height: 16),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: List.generate(11, (index) {
              final isSelected = _selectedScore == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedScore = index),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected ? _scoreColor(index) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? _scoreColor(index) : theme.dividerColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.nps_not_likely.tr(),
                  style: theme.textTheme.bodySmall),
              Text(LocaleKeys.nps_very_likely.tr(),
                  style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(LocaleKeys.nps_later.tr()),
        ),
        TextButton(
          onPressed: _selectedScore != null
              ? () => Navigator.of(context).pop(_selectedScore)
              : null,
          child: Text(LocaleKeys.nps_submit.tr()),
        ),
      ],
    );
  }

  Color _scoreColor(int score) {
    if (score >= 9) return Colors.green;
    if (score >= 7) return Colors.orange;
    return Colors.red;
  }
}
