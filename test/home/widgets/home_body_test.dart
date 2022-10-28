import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_api/hive_api.dart';
import 'package:journal/home/cubit/home_cubit.dart';
import 'package:journal/home/widgets/home_body.dart';
import 'package:journal/home/widgets/home_entry_tile.dart';
import 'package:journal/home/widgets/home_island.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/app_themes.dart';
import 'package:journal/res/widgets/custom_scroll_body.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:single_store_api/single_store_api.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

class MockDio extends Mock implements Dio {}

class MockUserRepository extends Mock implements UserRepository {}

class HiveApiMock extends Mock implements HiveApi {}

void main() {
  final dio = MockDio();
  final userRepository = MockUserRepository();
  final hiveApi = HiveApiMock();

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
      when(hiveApi.initialize).thenAnswer((_) async => true),
      when(() => hiveApi.get(any())).thenAnswer((_) => '1234'),
    },
  );

  testWidgets('HomeBody renders correctly', (tester) async {
    await tester.pumpApp(
      BlocProvider<HomeCubit>(
        create: (_) => HomeCubit(
          JournalRepository(
            SingleStoreApi(dio: dio),
          ),
          userRepository,
          KeyStoreRepository(
            hiveApi,
          ),
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
            userRepository,
            KeyStoreRepository(
              hiveApi,
            ),
          ),
          child: const HomeBody(),
        ),
      ),
    );
    await tester.pumpAndSettle();

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
            userRepository,
            KeyStoreRepository(
              hiveApi,
            ),
          ),
          child: const HomeBody(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
  });

  testWidgets('press add button', (tester) async {
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
            userRepository,
            KeyStoreRepository(
              hiveApi,
            ),
          ),
          child: const HomeBody(),
        ),
      ),
    );

    await tester.pumpAndSettle();

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

  testWidgets('press homeCategorySelector', (tester) async {
    await tester.pumpApp(
      Scaffold(
        body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => userRepository),
          ],
          child: BlocProvider<HomeCubit>(
            create: (_) => HomeCubit(
              JournalRepository(
                SingleStoreApi(dio: dio),
              ),
              userRepository,
              KeyStoreRepository(
                hiveApi,
              ),
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
            userRepository,
            KeyStoreRepository(
              hiveApi,
            ),
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

  testWidgets('press settings button', (tester) async {
    const width = 1920.0;
    const height = 1080.0;

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => userRepository,
          ),
          RepositoryProvider<JournalRepository>(
            create: (context) => JournalRepository(SingleStoreApi(dio: dio)),
          ),
          RepositoryProvider<KeyStoreRepository>(
            create: (context) => KeyStoreRepository(hiveApi),
          ),
        ],
        child: MaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
              context.read<JournalRepository>(),
              context.read<UserRepository>(),
              context.read<KeyStoreRepository>(),
            ),
            child: const HomeBody(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
  });

  testWidgets('press locked button', (tester) async {
    const width = 1920.0;
    const height = 1080.0;

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => userRepository,
          ),
          RepositoryProvider<JournalRepository>(
            create: (context) => JournalRepository(SingleStoreApi(dio: dio)),
          ),
          RepositoryProvider<KeyStoreRepository>(
            create: (context) => KeyStoreRepository(hiveApi),
          ),
        ],
        child: MaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
              context.read<JournalRepository>(),
              context.read<UserRepository>(),
              context.read<KeyStoreRepository>(),
            ),
            child: const HomeBody(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.lock));
    await tester.pumpAndSettle();
  });
}
