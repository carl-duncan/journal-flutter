// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/settings/settings.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

class MockDio extends Mock implements Dio {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final dio = MockDio();
  final userRepository = MockUserRepository();

  group('SettingsPage', () {
    group('route', () {
      test('is routable', () {
        expect(SettingsPage.route(), isA<MaterialPageRoute<dynamic>>());
      });
    });

    testWidgets('renders SettingsView', (tester) async {
      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<JournalRepository>(
              create: (_) => JournalRepository(
                SingleStoreApi(dio: dio),
              ),
            ),
            RepositoryProvider<UserRepository>(
              create: (_) => userRepository,
            ),
          ],
          child: SettingsPage(),
        ),
      );
      expect(find.byType(SettingsBody), findsOneWidget);
    });
  });
}
