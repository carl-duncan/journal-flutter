// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/home.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('HomeBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpApp(
        BlocProvider(
          create: (context) => HomeCubit(),
          child: HomeBody(),
        ),
      );
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
