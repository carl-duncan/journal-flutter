import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/home.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';

import '../../helpers/helpers.dart';

class MockDio extends Mock implements Dio {}

class MockAuth extends Mock implements AuthCategory {}

void main() {
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

  testWidgets('HomePage renders correctly', (tester) async {
    await tester.pumpApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<JournalRepository>(
            create: (_) => JournalRepository(
              SingleStoreApi(dio: dio),
            ),
          ),
          RepositoryProvider<AuthCategory>(
            create: (_) => authCategory,
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
