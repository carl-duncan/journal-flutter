import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/home/cubit/cubit.dart';
import 'package:journal/home/widgets/home_body.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:user_repository/user_repository.dart';

/// {@template home_page}
/// A description for HomePage
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  /// The static route for HomePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (context) => HomeCubit(
        context.read<JournalRepository>(),
        context.read<UserRepository>(),
        context.read<KeyStoreRepository>(),
        l10n,
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: const Scaffold(
          body: SelectionArea(child: HomeView()),
        ),
      ),
    );
  }
}

/// {@template home_view}
/// Displays the Body of HomeView
/// {@endtemplate}
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}
