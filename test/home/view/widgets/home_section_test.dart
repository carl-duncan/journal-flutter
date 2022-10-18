// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/home_section.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('HomeSection', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpApp(
        CustomScrollView(
          slivers: const [
            HomeSection(
              title: 'Test Title',
              entries: [],
            ),
          ],
        ),
      );
      expect(find.byType(Text), findsWidgets);
      expect(find.text('Test Title'), findsOneWidget);
    });
  });
}
