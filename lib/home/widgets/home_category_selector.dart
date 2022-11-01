import 'package:flutter/material.dart';
import 'package:journal/l10n/l10n.dart';

enum HomeCategory { entries, gallery }

class HomeCategorySelector extends StatelessWidget {
  const HomeCategorySelector({
    super.key,
    required this.category,
    required this.onEntriesPressed,
  });
  final HomeCategory category;
  final VoidCallback onEntriesPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const selectedTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    const unselectedTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w100,
      color: Colors.grey,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onEntriesPressed,
          child: ColoredBox(
            key: const Key('homeCategorySelector_entries'),
            color: Colors.transparent,
            child: Text(
              l10n.entries,
              style: category == HomeCategory.entries
                  ? selectedTextStyle
                  : unselectedTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
