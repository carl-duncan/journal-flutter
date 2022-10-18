// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:journal/home/widgets/home_entry_tile.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('HomeEntryTile', () {
    testWidgets('renders Text', (tester) async {
      final date = DateTime.now();
      const title = 'title';
      const subtitle = 'subtitle';
      await tester.pumpApp(
        HomeEntryTile(
          date: date,
          title: title,
          subtitle: subtitle,
        ),
      );

      final dayOfWeek = DateFormat('EEE').format(date);
      final dayOfMonth = DateFormat('d').format(date);
      final dayOfMonthPadded =
          dayOfMonth.length == 1 ? '0$dayOfMonth' : dayOfMonth;

      expect(find.text(dayOfWeek), findsOneWidget);
      expect(find.text(dayOfMonthPadded), findsOneWidget);
      expect(find.text('$title$subtitle', findRichText: true), findsOneWidget);
    });
  });
}
