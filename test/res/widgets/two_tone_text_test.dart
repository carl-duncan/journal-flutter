import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/res/widgets/two_tone_text.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('TwoToneText', (WidgetTester tester) async {
    await tester.pumpApp(
      TwoToneText(
        key: UniqueKey(),
        firstText: 'The most',
        secondText: ' secure',
        fontSize: 68,
        thirdText: ' personal journal app.',
      ),
    );

    expect(
      find.text('The most secure personal journal app.', findRichText: true),
      findsOneWidget,
    );
  });
}
