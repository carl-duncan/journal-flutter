// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:journal/home/home.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/app_themes.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:single_store_api/single_store_api.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final journalApi = SingleStoreApi(dio: dio);
    return Authenticator(
      child: RepositoryProvider(
        create: (context) => JournalRepository(journalApi),
        child: MaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: Authenticator.builder(),
          home: const HomePage(),
        ),
      ),
    );
  }
}
