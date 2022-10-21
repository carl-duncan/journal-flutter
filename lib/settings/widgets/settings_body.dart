import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/widgets/custom_scroll_body.dart';
import 'package:journal/settings/cubit/cubit.dart';

import '../../res/spacers.dart';

/// {@template settings_body}
/// Body of the SettingsPage.
///
/// Add what it does
/// {@endtemplate}
class SettingsBody extends StatelessWidget {
  /// {@macro settings_body}
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return CustomScrollBody(
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Spacers.hPagePadding),
              sliver: SliverAppBar(
                systemOverlayStyle: theme.brightness == Brightness.dark
                    ? SystemUiOverlayStyle.light
                    : SystemUiOverlayStyle.dark,
                title: Text(
                  l10n.settings,
                  style: theme.textTheme.headline6!.copyWith(fontSize: 20),
                ),
                leading: const SizedBox.shrink(),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: theme.iconTheme.color,
                      size: 35,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
                centerTitle: true,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
          isLoading: false,
        );
      },
    );
  }
}
