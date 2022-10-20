import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/res/widgets/custom_scroll_body.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('CustomScrollBody renders correctly', (tester) async {
    final scrollController = ScrollController();
    await tester.pumpApp(
      CustomScrollBody(
        controller: scrollController,
        isLoading: false,
        slivers: const [],
      ),
    );
    expect(find.byType(CustomScrollBody), findsOneWidget);
  });

  testWidgets('CustomScrollBody isLoading is true', (tester) async {
    final scrollController = ScrollController();
    await tester.pumpApp(
      CustomScrollBody(
        controller: scrollController,
        isLoading: true,
        slivers: const [],
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
