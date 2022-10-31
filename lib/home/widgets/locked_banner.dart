import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/l10n/l10n.dart';

class LockedBanner extends StatelessWidget {
  const LockedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).iconTheme.color,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.pencil,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              l10n.editorLocked,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
