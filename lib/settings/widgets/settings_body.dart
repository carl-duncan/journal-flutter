import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/spacers.dart';
import 'package:journal/res/widgets/custom_scroll_body.dart';
import 'package:journal/settings/cubit/cubit.dart';
import 'package:journal/settings/widgets/settings_tile.dart';

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
    final cubit = context.read<SettingsCubit>();
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
                    key: const Key('settings_close'),
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
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacers.hPagePadding,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  SettingsTile(
                    title: l10n.logout,
                    color: Colors.red,
                    subtitle: l10n.signOutOfTheJournalAndReturnToTheLoginScreen,
                    icon: Icons.logout,
                    onTap: cubit.signOut,
                  )
                ]),
              ),
            )
          ],
          isLoading: false,
        );
      },
    );
  }
}
