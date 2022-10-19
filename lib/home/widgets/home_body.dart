import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/home/home.dart';
import 'package:journal/res/spacers.dart';
import 'package:journal/res/widgets/custom_scroll_body.dart';
import 'package:journal_api/journal_api.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// {@template home_body}
/// Body of the HomePage.
///
/// Add what it does
/// {@endtemplate}
class HomeBody extends StatelessWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final entriesByMonth = _getEntriesByMonth(state.entries);
        return CustomScrollBody(
          isLoading: state.isLoading,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(top: 60, bottom: 50),
              sliver: SliverToBoxAdapter(
                child: HomeCategorySelector(category: HomeCategory.entries),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Spacers.hPagePadding),
              sliver: MultiSliver(
                children: entriesByMonth.entries.map((entry) {
                  return HomeSection(
                    title: entry.key,
                    entries: entry.value,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Map<String, List<Entry>> _getEntriesByMonth(List<Entry> entries) {
    final entriesByMonth = <String, List<Entry>>{};
    for (final entry in entries) {
      final key = DateFormat.MMMM().add_y().format(entry.createdAt);
      if (entriesByMonth.containsKey(key)) {
        entriesByMonth[key]!.add(entry);
      } else {
        entriesByMonth[key] = [entry];
      }
      if (!entriesByMonth[key]!.contains(entry)) {
        entriesByMonth[key]!.add(entry);
      }
    }
    return entriesByMonth;
  }
}
