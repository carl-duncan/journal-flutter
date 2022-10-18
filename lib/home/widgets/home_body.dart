import 'package:flutter/material.dart';
import 'package:wasm_journal_mobile/home/cubit/cubit.dart';
import 'package:wasm_journal_mobile/l10n/l10n.dart';

/// {@template home_body}
/// Body of the HomePage.
///
/// Add what it does
/// {@endtemplate}
class HomeBody extends StatelessWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Center(child: Text(l10n.helloWorld));
      },
    );
  }
}
