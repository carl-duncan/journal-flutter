import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/res/utils/transition.dart';
import '../../helpers/helpers.dart';

void main() {
  testWidgets('transition test', (WidgetTester tester) async {
    await tester.pumpApp(const TestPage());

    await tester.tap(find.byKey(const Key('button')));
    await tester.pumpAndSettle();

    expect(find.byType(Container), findsOneWidget);
  });
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        key: const Key('button'),
        child: const Text('Go to new page'),
        onPressed: () {
          Navigator.push(
            context,
            createRoute(Container()),
          );
        },
      ),
    ));
  }
}
