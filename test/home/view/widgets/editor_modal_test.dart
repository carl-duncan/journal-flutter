import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/editor_modal.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('EditorModal', () {
    testWidgets('EditorModal', (tester) async {
      await tester.pumpApp(
        const EditorModal(),
      );
      expect(find.byType(EditorModal), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(2));
      expect(find.byType(GestureDetector), findsNWidgets(2));
    });

    testWidgets('EditorModal - close', (tester) async {
      await tester.pumpApp(
        const EditorModal(),
      );
      expect(find.byType(EditorModal), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byType(EditorModal), findsNothing);
    });

    testWidgets('EditorModal - save', (tester) async {
      await tester.pumpApp(
        const EditorModal(),
      );
      expect(find.byType(EditorModal), findsOneWidget);
      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();
      expect(find.byType(EditorModal), findsNothing);
    });
  });
}
