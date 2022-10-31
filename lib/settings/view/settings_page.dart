import 'package:flutter/material.dart';
import 'package:journal/settings/cubit/cubit.dart';
import 'package:journal/settings/widgets/settings_body.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:user_repository/user_repository.dart';

/// {@template settings_page}
/// A description for SettingsPage
/// {@endtemplate}
class SettingsPage extends StatelessWidget {
  /// {@macro settings_page}
  const SettingsPage({super.key});

  /// The static route for SettingsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(
        context.read<JournalRepository>(),
        context.read<UserRepository>(),
        context.read<KeyStoreRepository>(),
      ),
      child: const Scaffold(
        body: SettingsView(),
      ),
    );
  }
}

/// {@template settings_view}
/// Displays the Body of SettingsView
/// {@endtemplate}
class SettingsView extends StatelessWidget {
  /// {@macro settings_view}
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBody();
  }
}
