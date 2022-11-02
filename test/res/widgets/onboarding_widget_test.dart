import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/res/widgets/onboarding_widget.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('Onboarding widget', (WidgetTester tester) async {
    const width = 1920.0;
    const height = 1080.0;

    await tester.binding.setSurfaceSize(const Size(height, width));

    await tester.pumpApp(
      OnboardingWidget(onContinue: () {}),
    );

    expect(
      find.text('The\nmost secure personal journal app.', findRichText: true),
      findsOneWidget,
    );

    await tester.tap(find.byType(ElevatedButton));
  });
}
