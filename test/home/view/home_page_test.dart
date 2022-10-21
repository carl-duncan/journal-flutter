import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/home.dart';
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
      when(
        userRepository.getEncryptionKey,
      ).thenAnswer(
        (_) async => '1234',
      ),
    },
  );

  testWidgets('HomePage renders correctly', (tester) async {
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
        child: const HomePage(),
      ),
    );
    expect(find.byType(HomeBody), findsOneWidget);
  });

  test('HomePage.route() returns correct route', () {
    expect(HomePage.route(), isA<MaterialPageRoute<dynamic>>());
  });
}
