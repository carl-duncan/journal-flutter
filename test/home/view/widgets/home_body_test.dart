// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/home.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('HomeBody', () {
    testWidgets('renders HomeCategorySelector', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) => HomeCubit(),
          child: HomeBody(),
        ),
      );
      expect(find.byType(HomeCategorySelector), findsOneWidget);
    });
  });
}
