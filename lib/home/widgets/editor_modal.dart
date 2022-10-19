import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal_api/journal_api.dart';

class EditorModal extends StatelessWidget {
  const EditorModal({
    super.key,
    this.entry,
  });

  final Entry? entry;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat(
      'MMMM dd, yyyy',
      Localizations.localeOf(context).languageCode,
    );
    final formattedDate = formatter.format(now);
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    return Material(
      color: Theme.of(context).cardColor.withOpacity(1),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30)
              .copyWith(bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                  // current date
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  // save button
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.check,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: size.height * 0.7,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: l10n.enterYourTextHere,
                    hintStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // remove background color
                    filled: false,
                  ),
                  maxLines: 1000,
                  maxLength: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
