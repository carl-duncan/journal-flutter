// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/home_entry_title.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('HomeEntryTitle', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpApp(
        HomeEntryTitle(title: 'February 2022', subtitle: '2 entries'),
      );
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.text('February 2022'), findsOneWidget);
      expect(find.text('2 entries'), findsOneWidget);
    });
  });
}
