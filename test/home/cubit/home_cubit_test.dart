// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/cubit/cubit.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';
import 'package:user_repository/user_repository.dart';

class MockDio extends Mock implements Dio {}

class MockUserRepository extends Mock implements UserRepository {}

class MockKeyStoreRepository extends Mock implements KeyStoreRepository {}

class MockAppLocalizations extends Mock implements AppLocalizations {}

void main() {
  group('HomeCubit', () {
    final dio = MockDio();
    final userRepository = MockUserRepository();
    final keyStoreRepository = MockKeyStoreRepository();
    final localizations = MockAppLocalizations();

    group('Current User', () {
      setUpAll(
        () => {
          when(userRepository.getUserId).thenAnswer(
            (_) async => '1234',
          ),
          when(
            () => dio.post<Map<String, dynamic>>(
              any(),
              data: any<Map<String, dynamic>>(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: {
                'results': [
                  {
                    'rows': [
                      {
                        'id': 0,
                        'title': 'Test Title',
                        'body': 'Body',
                        'created_at': '0000-00-00 00:00:00',
                        'updated_at': '0000-00-00 00:00:00',
                        'user_id': '1234'
                      },
                      {
                        'id': 1,
                        'title': 'Test Title 2',
                        'body': 'Body',
                        'created_at': '0000-00-00 00:00:00',
                        'updated_at': '0000-00-00 00:00:00',
                        'user_id': '1234'
                      },
                    ]
                  }
                ]
              },
            ),
          ),
          when(keyStoreRepository.initialize).thenAnswer((_) async => true),
          when(() => keyStoreRepository.get(any())).thenAnswer((_) => '1234'),
          when(() => keyStoreRepository.set(any(), any()))
              .thenAnswer((_) async {}),
          when(userRepository.signOut).thenAnswer((_) async {}),
        },
      );

      test('getEntries', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        final cubit = HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        );

        await cubit.getEntries();

        expect(cubit.state.entries, isA<List<Entry>>());
        expect(cubit.state.entries, isNotEmpty);
      });

      test('toggleSearchBar', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        final cubit = HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        );

        expect(cubit.state.showSearchBar, isFalse);

        await cubit.toggleSearchBar();

        expect(cubit.state.showSearchBar, isTrue);

        await cubit.toggleSearchBar();

        expect(cubit.state.showSearchBar, isFalse);
      });

      test('toggleCategory', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        final cubit = HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        );

        expect(cubit.state.category, HomeCategory.entries);

        cubit.toggleCategory(HomeCategory.gallery);

        expect(cubit.state.category, HomeCategory.gallery);
      });

      test('isLoading', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        final cubit = HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        );

        expect(cubit.state.isLoading, isTrue);

        cubit.isLoading(isLoading: false);

        expect(cubit.state.isLoading, isFalse);
      });

      test('createEntry', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        final cubit = HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        );

        await cubit.toggleLock();

        await cubit.createEntry('Test Title', 'Test Message from Carl Duncan');

        await cubit.toggleLock();

        await cubit.createEntry('Test Title', 'Test Message from Carl Duncan');

        await cubit.toggleLock();

        expect(cubit.state.entries, isA<List<Entry>>());
        expect(cubit.state.entries, isNotEmpty);
      });

      test('searchEntries', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        final cubit = HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        );

        await cubit.searchEntries('Test');

        expect(cubit.state.searchEntries, isA<List<Entry>>());
        expect(cubit.state.searchEntries, isNotEmpty);
      });

      test('updateEntry', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        final cubit = HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        );

        await cubit.toggleLock();

        await cubit.updateEntry(
          Entry(
            id: 0,
            title: 'Test Title',
            body: 'Body',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            userId: '1234',
          ),
          'Test Title',
          'Test Message from Carl Duncan',
        );

        expect(cubit.state.entries, isA<List<Entry>>());
        expect(cubit.state.entries, isNotEmpty);
      });

      test('setKey', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        HomeCubit(repository, userRepository, keyStoreRepository, localizations)
            .setKeyAndRefresh('1234');
      });

      test('signOut', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        HomeCubit(repository, userRepository, keyStoreRepository, localizations)
            .signOut();
      });
    });

    group('New User', () {
      setUpAll(
        () => {
          when(userRepository.getUserId).thenAnswer(
            (_) async => '1234',
          ),
          when(
            () => dio.post<Map<String, dynamic>>(
              any(),
              data: any<Map<String, dynamic>>(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: {
                'results': [
                  {'rows': <Map<String, dynamic>>[]}
                ]
              },
            ),
          ),
          when(keyStoreRepository.initialize).thenAnswer((_) async => true),
          when(() => keyStoreRepository.get(any())).thenAnswer((_) => null),
          when(() => keyStoreRepository.set(any(), any()))
              .thenAnswer((_) async {}),
          when(userRepository.signOut).thenAnswer((_) async {}),
          when(() => keyStoreRepository.generate(any()))
              .thenAnswer((_) async => '1234'),
          when(() => localizations.thankYouForTheSupport)
              .thenReturn('Thank you for the support!'),
          when(() => localizations.thankYouForTheSupportDescription)
              .thenReturn('Thanks'),
        },
      );

      test('setUpNewUser', () async {
        final api = SingleStoreApi(dio: dio);
        final repository = JournalRepository(api);
        await HomeCubit(
          repository,
          userRepository,
          keyStoreRepository,
          localizations,
        ).setUpNewUser();
      });
    });
  });
}
