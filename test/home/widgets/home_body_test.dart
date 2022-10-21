import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/cubit/home_cubit.dart';
import 'package:journal/home/widgets/home_body.dart';
import 'package:journal/home/widgets/home_entry_tile.dart';
import 'package:journal/home/widgets/home_island.dart';
import 'package:journal/res/widgets/custom_scroll_body.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';

import '../../helpers/helpers.dart';

class MockDio extends Mock implements Dio {}

class MockAuth extends Mock implements AuthCategory {}

void main() {
  final dio = MockDio();
  final authCategory = MockAuth();

  setUpAll(
    () => {
      when(authCategory.getCurrentUser).thenAnswer(
        (_) async => AuthUser(
          userId: '1234',
          username: 'test',
        ),
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
      )
    },
  );

  testWidgets('HomeBody renders correctly', (tester) async {
    await tester.pumpApp(
      BlocProvider<HomeCubit>(
        create: (_) => HomeCubit(
          JournalRepository(
            SingleStoreApi(dio: dio),
          ),
          authCategory,
        ),
        child: const HomeBody(),
      ),
    );
    expect(find.byType(HomeBody), findsOneWidget);
  });

  testWidgets('HomeIsland is hidden when scrolling down', (tester) async {
    const width = 1920.0;
    const height = 1080.0;

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            JournalRepository(
              SingleStoreApi(dio: dio),
            ),
            authCategory,
          ),
          child: const HomeBody(),
        ),
      ),
    );
    expect(find.byType(HomeIsland), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.drag(find.byType(CustomScrollBody), const Offset(0, -100));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(CustomScrollBody), const Offset(0, 100));
  });

  testWidgets('press search button', (tester) async {
    const width = 1920.0;
    const height = 1080.0;

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            JournalRepository(
              SingleStoreApi(dio: dio),
            ),
            authCategory,
          ),
          child: const HomeBody(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
  });

  testWidgets('press add button', (tester) async {
    const width = 1920.0;
    const height = 1080.0;

    when(authCategory.getCurrentUser).thenAnswer(
      (_) async => AuthUser(
        userId: '1234',
        username: 'test',
      ),
    );

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            JournalRepository(
              SingleStoreApi(dio: dio),
            ),
            authCategory,
          ),
          child: const HomeBody(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final textField = find.byKey(const Key('editor_modal_text_field'));
    expect(textField, findsOneWidget);

    await tester.tap(find.byKey(const Key('editor_modal_close_button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(textField, 'Test Title for Carl Duncan');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('editor_modal_save_button')));
    await tester.pumpAndSettle();
  });

  testWidgets('press settings button', (tester) async {
    const width = 1920.0;
    const height = 1080.0;

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            JournalRepository(
              SingleStoreApi(dio: dio),
            ),
            authCategory,
          ),
          child: const HomeBody(),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
  });

  testWidgets('press homeCategorySelector', (tester) async {
    await tester.pumpApp(
      Scaffold(
        body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => authCategory),
          ],
          child: BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(
              JournalRepository(
                SingleStoreApi(dio: dio),
              ),
              authCategory,
            ),
            child: const HomeBody(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('homeCategorySelector_gallery')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('homeCategorySelector_entries')));
    await tester.pumpAndSettle();
  });

  testWidgets('press entryTile', (tester) async {
    const width = 1920.0;
    const height = 1080.0;

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      Scaffold(
        body: BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            JournalRepository(
              SingleStoreApi(dio: dio),
            ),
            authCategory,
          ),
          child: const HomeBody(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byType(HomeEntryTile).first);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('editor_modal_save_button')));
    await tester.pumpAndSettle();
  });
}
