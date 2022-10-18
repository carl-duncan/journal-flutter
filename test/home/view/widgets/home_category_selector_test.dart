// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('HomeBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpApp(
        HomeCategorySelector(category: HomeCategory.gallery),
      );
      expect(find.byType(Text), findsNWidgets(3));
    });
  });
}
