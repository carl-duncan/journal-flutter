// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/home_entry_tile.dart';
import 'package:journal/home/widgets/home_section.dart';
import 'package:journal_api/journal_api.dart';
import '../../helpers/helpers.dart';

void main() {
  group('HomeSection', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                HomeSection(
                  title: 'Test Title',
                  entries: [
                    Entry(
                      id: 1,
                      title: 'Test Title',
                      body: 'Test Body',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      userId: '1234567890',
                    ),
                  ],
                  onEntryTileTap: (entry) {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(HomeEntryTile), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(SliverList), findsOneWidget);
    });

    testWidgets('HomeSection onFunctionTap', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                HomeSection(
                  title: 'Test Title',
                  entries: [
                    Entry(
                      id: 1,
                      title: 'Test Title',
                      body: 'Test Body from the Unit Test',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      userId: '1234567890',
                    ),
                  ],
                  onEntryTileTap: (entry) {
                    Navigator.of(tester.element(find.byType(Scaffold))).push(
                      MaterialPageRoute<Scaffold>(
                        builder: (context) => Scaffold(
                          body: Text('NEW PAGE'),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );

      final entryTile = find.byType(HomeEntryTile);
      expect(entryTile, findsOneWidget);

      final allGestureDetectors = find.byType(GestureDetector);

      for (var i = 0; i < allGestureDetectors.evaluate().length; i++) {
        await tester.tap(allGestureDetectors.at(i));
        await tester.pumpAndSettle();
      }
    });
  });
}
