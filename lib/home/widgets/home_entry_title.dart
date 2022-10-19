import 'package:flutter/material.dart';

class HomeEntryTitle extends StatelessWidget {
  const HomeEntryTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.headline6!.copyWith(fontSize: 16),
        ),
        Text(
          subtitle,
          style: theme.textTheme.subtitle2!.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
