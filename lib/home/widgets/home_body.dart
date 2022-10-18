import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/home/home.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/spacers.dart';
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
        final entriesByMonth = <String, List<Entry>>{};
        for (final entry in state.entries) {
          final month = entry.createdAt.month;
          final year = entry.createdAt.year;
          final key = '$month/$year';
          if (entriesByMonth.containsKey(key)) {
            entriesByMonth[key]!.add(entry);
          } else {
            entriesByMonth[key] = [entry];
          }
          entriesByMonth[key]!.add(entry);
        }
        return CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
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
              sliver: _parseEntries(state.entries, context),
            ),
          ],
        );
      },
    );
  }

  MultiSliver _parseEntries(List<Entry> entries, BuildContext context) {
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
    final children = <Widget>[];
    final i10n = AppLocalizations.of(context);

    for (final entry in entriesByMonth.entries) {
      children.add(
        MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: HomeEntryTitle(
                title: entry.key,
                subtitle: '${entry.value.length} ${i10n.entries}',
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: HomeEntryTile(
                      date: entry.value[index].createdAt,
                      title: '${entry.value[index].title} ',
                      subtitle: entry.value[index].body,
                    ),
                  );
                },
                childCount: entry.value.length,
              ),
            ),
          ],
        ),
      );
    }

    return MultiSliver(children: children);
  }
}
