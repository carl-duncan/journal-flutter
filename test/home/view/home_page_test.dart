// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wasm_journal_mobile/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomePage', () {
    group('route', () {
      test('is routable', () {
        expect(HomePage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders HomeView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: HomePage()));
      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
