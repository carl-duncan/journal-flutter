// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:dio/dio.dart';
import 'package:journal_api/journal_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final dio = MockDio();

  group('SingleStoreApi', () {
    final api = SingleStoreApi(
      dio: dio,
      baseUrl: 'baseUrl',
      database: 'database',
      username: 'username',
      password: 'password',
    );
    test('can be instantiated', () {
      expect(api, isNotNull);
    });

    test('getAllEntries', () {
      when(
        () => dio.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
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

      expect(api.getEntries(), completion(isA<List<Entry>>()));
    });
  });
}
