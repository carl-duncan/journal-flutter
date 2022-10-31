import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/onboarding_body.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets(
    'test onboarding body',
    (widgetTester) => widgetTester
        .pumpApp(OnboardingBody(onContinue: (string) {}, onClose: () {})),
  );

  testWidgets(
    'test onboarding body',
    (widgetTester) async {
      await widgetTester.pumpApp(
        OnboardingBody(onContinue: (string) {}, onClose: () {}),
      );
      await widgetTester.tap(find.byType(GestureDetector));
    },
  );

  testWidgets(
    'test onboarding body',
    (widgetTester) async {
      await widgetTester.pumpApp(
        OnboardingBody(onContinue: (string) {}, onClose: () {}),
      );
      await widgetTester.enterText(find.byType(TextField), 'test');
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
    },
  );
}
