// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/settings/cubit/cubit.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';
import 'package:user_repository/user_repository.dart';

class MockDio extends Mock implements Dio {}

class MockUserRepository extends Mock implements UserRepository {}

class MockKeyStoreRepository extends Mock implements KeyStoreRepository {}

void main() {
  final dio = MockDio();
  final userRepository = MockUserRepository();
  final api = SingleStoreApi(dio: dio);
  final repository = JournalRepository(api);
  final keyStoreRepository = MockKeyStoreRepository();

  // setup sign out
  setUpAll(
    () => {
      when(userRepository.signOut).thenAnswer((_) async {}),
      when(userRepository.signOut).thenAnswer((_) async {}),
    },
  );

  group('SettingsCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          SettingsCubit(repository, userRepository, keyStoreRepository),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final settingsCubit =
          SettingsCubit(repository, userRepository, keyStoreRepository);
      expect(settingsCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<SettingsCubit, SettingsState>(
      'signOut emits nothing',
      build: () =>
          SettingsCubit(repository, userRepository, keyStoreRepository),
      act: (cubit) => cubit.signOut(),
      expect: () => <SettingsState>[],
    );

    blocTest<SettingsCubit, SettingsState>(
      'copy emits nothing',
      build: () =>
          SettingsCubit(repository, userRepository, keyStoreRepository),
      act: (cubit) => cubit.copyKey(),
      setUp: () {
        WidgetsFlutterBinding.ensureInitialized();
      },
      expect: () => <SettingsState>[],
    );
  });
}
