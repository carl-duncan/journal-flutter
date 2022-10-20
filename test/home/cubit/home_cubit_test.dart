// ignore_for_file: prefer_const_constructors

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/cubit/cubit.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';

class MockDio extends Mock implements Dio {}

class MockAuth extends Mock implements AuthCategory {}

void main() {
  group('HomeCubit', () {
    final dio = MockDio();
    final authCategory = MockAuth();

    setUp(
      () => when(
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
                ]
              }
            ]
          },
        ),
      ),
    );

    test('getEntries', () async {
      final api = SingleStoreApi(dio: dio);
      final repository = JournalRepository(api);
      final cubit = HomeCubit(repository, authCategory);

      await cubit.getEntries();

      expect(cubit.state.entries, isA<List<Entry>>());
      expect(cubit.state.entries, isNotEmpty);
    });

    test('toggleSearchBar', () async {
      final api = SingleStoreApi(dio: dio);
      final repository = JournalRepository(api);
      final cubit = HomeCubit(repository, authCategory);

      expect(cubit.state.showSearchBar, isFalse);

      cubit.toggleSearchBar();

      expect(cubit.state.showSearchBar, isTrue);
    });

    test('toggleCategory', () async {
      final api = SingleStoreApi(dio: dio);
      final repository = JournalRepository(api);
      final cubit = HomeCubit(repository, authCategory);

      expect(cubit.state.category, HomeCategory.entries);

      cubit.toggleCategory(HomeCategory.gallery);

      expect(cubit.state.category, HomeCategory.gallery);
    });

    test('isLoading', () async {
      final api = SingleStoreApi(dio: dio);
      final repository = JournalRepository(api);
      final cubit = HomeCubit(repository, authCategory);

      expect(cubit.state.isLoading, isTrue);

      cubit.isLoading(isLoading: false);

      expect(cubit.state.isLoading, isFalse);
    });

    test('createEntry', () async {
      final api = SingleStoreApi(dio: dio);
      final repository = JournalRepository(api);
      final cubit = HomeCubit(repository, authCategory);

      when(authCategory.getCurrentUser).thenAnswer(
        (_) async => AuthUser(
          userId: '1234',
          username: 'test',
        ),
      );

      await cubit.createEntry('Test Message from Carl Duncan', authCategory);

      expect(cubit.state.entries, isA<List<Entry>>());
      expect(cubit.state.entries, isNotEmpty);
    });

    test('searchEntries', () async {
      final api = SingleStoreApi(dio: dio);
      final repository = JournalRepository(api);
      final cubit = HomeCubit(repository, authCategory);

      await cubit.searchEntries('Test');

      expect(cubit.state.entries, isA<List<Entry>>());
      expect(cubit.state.entries, isNotEmpty);
    });
  });
}
