// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/settings/settings.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';
import 'package:user_repository/user_repository.dart';

import '../../../helpers/helpers.dart';

class MockDio extends Mock implements Dio {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final dio = MockDio();
  final userRepository = MockUserRepository();
  final api = SingleStoreApi(dio: dio);
  final repository = JournalRepository(api);

  group('SettingsBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) => SettingsCubit(repository, userRepository),
          child: Scaffold(body: SettingsBody()),
        ),
      );

      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('settings_close click', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) => SettingsCubit(repository, userRepository),
          child: Scaffold(body: SettingsBody()),
        ),
      );

      await tester.tap(find.byKey(const Key('settings_close')));
      await tester.pumpAndSettle();
    });
  });
}
