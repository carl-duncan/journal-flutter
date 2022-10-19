import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeEntryTile extends StatelessWidget {
  const HomeEntryTile({
    super.key,
    required this.date,
    required this.title,
    required this.subtitle,
  });
  final DateTime date;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = DateFormat('EEE').format(date);
    final dayOfMonth = DateFormat('d').format(date);
    final dayOfMonthPadded =
        dayOfMonth.length == 1 ? '0$dayOfMonth' : dayOfMonth;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(dayOfWeek, style: const TextStyle(fontSize: 18)),
            Text(dayOfMonthPadded, style: const TextStyle(fontSize: 30)),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
