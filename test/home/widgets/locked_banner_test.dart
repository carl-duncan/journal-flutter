import 'package:flutter_test/flutter_test.dart';
import 'package:journal/home/widgets/locked_banner.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets(
    'test open locked banner',
    (widgetTester) => widgetTester.pumpApp(const LockedBanner()),
  );
}
