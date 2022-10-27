import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/l10n/l10n.dart';

class EditorModal extends StatelessWidget {
  const EditorModal({
    super.key,
    required this.onSave,
    required this.bodyController,
    required this.onClose,
    required this.titleController,
    required this.isVisualizeVisible,
  });

  final TextEditingController bodyController;

  final TextEditingController titleController;

  final VoidCallback onSave;

  final VoidCallback onClose;

  final bool isVisualizeVisible;

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
                    key: const Key('editor_modal_close_button'),
                    onTap: onClose,
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
                    key: const Key('editor_modal_save_button'),
                    onTap: onSave,
                    child: const Icon(
                      Icons.check,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              if (isVisualizeVisible)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    color: Theme.of(context).iconTheme.color,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.wand_stars,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            l10n.visualizeYourEntry,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        key: const Key('editor_modal_title_field'),
                        autofocus: true,
                        controller: titleController,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 24,
                            ),
                        cursorColor: Theme.of(context).iconTheme.color,
                        decoration: InputDecoration(
                          hintText: l10n.enterYourTitleHere,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          counterText: '',
                          // remove background color
                          filled: false,
                        ),
                        maxLength: 50,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: size.height * 0.5,
                child: TextField(
                  key: const Key('editor_modal_text_field'),
                  controller: bodyController,
                  autofocus: true,
                  cursorColor: Theme.of(context).iconTheme.color,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
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
