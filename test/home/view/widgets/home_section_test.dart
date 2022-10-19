// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/home_entry_tile.dart';
import 'package:journal/home/widgets/home_section.dart';
import 'package:journal_api/journal_api.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('HomeSection', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpApp(
        CustomScrollView(
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
            ),
          ],
        ),
      );
      expect(find.byType(Text), findsWidgets);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(SliverList), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(HomeEntryTile), findsWidgets);
    });
  });
}
