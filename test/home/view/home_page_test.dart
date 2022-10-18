// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    group('route', () {
      test('is route-able', () {
        expect(HomePage.route(), isA<MaterialPageRoute<dynamic>>());
      });
    });

    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp(HomePage());
      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
