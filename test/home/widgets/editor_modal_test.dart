import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/editor_modal.dart';

import '../../helpers/helpers.dart';

void main() {
  group('EditorModal', () {
    final controller = TextEditingController();
    final titleController = TextEditingController();

    testWidgets('EditorModal', (tester) async {
      await tester.pumpApp(
        EditorModal(
          bodyController: controller,
          onSave: () {},
          onClose: () {},
          titleController: titleController,
          isEditRowVisible: true,
          onDelete: () {},
          onVisualize: () {},
        ),
      );
      expect(find.byType(EditorModal), findsOneWidget);
      expect(find.byType(TextField).first, findsOneWidget);
      expect(find.byType(TextField).last, findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(4));
      expect(find.byType(GestureDetector), findsNWidgets(4));
    });

    testWidgets('EditorModal - close', (tester) async {
      await tester.pumpApp(
        EditorModal(
          bodyController: controller,
          titleController: titleController,
          onSave: () {},
          onClose: () {},
          isEditRowVisible: true,
          onDelete: () {},
          onVisualize: () {},
        ),
      );
      expect(find.byType(EditorModal), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
    });

    testWidgets('EditorModal - save', (tester) async {
      await tester.pumpApp(
        EditorModal(
          bodyController: controller,
          titleController: titleController,
          onSave: () {},
          onClose: () {},
          isEditRowVisible: false,
          onDelete: () {},
          onVisualize: () {},
        ),
      );
      expect(find.byType(EditorModal), findsOneWidget);
      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();
    });
  });
}
