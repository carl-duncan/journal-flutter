// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/cubit/cubit.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('HomeCubit', () {
    final dio = MockDio();

    test('getAllEntries', () async {
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
                ]
              }
            ]
          },
        ),
      );

      final api = SingleStoreApi(dio: dio);
      final repository = JournalRepository(api);
      final cubit = HomeCubit(repository);

      await cubit.getEntries();

      expect(cubit.state.entries, isA<List<Entry>>());
      expect(cubit.state.entries, isNotEmpty);
    });
  });
}
