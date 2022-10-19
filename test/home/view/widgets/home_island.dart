import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/home_island.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('HomeIsland', () {
    testWidgets('HomeIsland', (tester) async {
      await tester.pumpApp(
        HomeIsland(
          onAddPressed: () {
            log('onAddPressed');
          },
          onSearchPressed: () {
            log('onSearchPressed');
          },
          onSettingsPressed: () {
            log('onSettingsPressed');
          },
        ),
      );
      expect(find.byType(HomeIsland), findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(3));
      expect(find.byType(GestureDetector), findsNWidgets(3));
    });
  });
}
