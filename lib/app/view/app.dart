// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:authentication_helper/authentication_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_api/hive_api.dart';
import 'package:journal/home/home.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/app_themes.dart';
import 'package:journal/res/widgets/onboarding_widget.dart';
import 'package:journal/resolvers/localized_button_resolver.dart';
import 'package:journal/resolvers/localized_country_resolver.dart';
import 'package:journal/resolvers/localized_input_resolver.dart';
import 'package:journal/resolvers/localized_title_resolver.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:single_store_api/single_store_api.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const stringResolver = AuthStringResolver(
      buttons: LocalizedButtonResolver(),
      countries: LocalizedCountryResolver(),
      titles: LocalizedTitleResolver(),
      inputs: LocalizedInputResolver(),
    );

    return Authenticator(
      stringResolver: stringResolver,
      initialStep: AuthenticatorStep.onboarding,
      authenticatorBuilder: (context, authStep) {
        // ignore: missing_enum_constant_in_switch
        switch (authStep.currentStep) {
          case AuthenticatorStep.onboarding:
            return OnboardingWidget(
              key: UniqueKey(),
              onContinue: () {
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle.dark,
                );
                authStep.changeStep(AuthenticatorStep.signIn);
              },
            );
        }
        return null;
      },
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => JournalRepository(SingleStoreApi(dio: Dio())),
          ),
          RepositoryProvider(
            create: (context) => const KeyStoreRepository(HiveApi('journal')),
          ),
          RepositoryProvider(create: (context) => const UserRepository()),
          RepositoryProvider<AuthenticationHelper>(
            create: (context) => AuthenticationHelper(),
          ),
        ],
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
