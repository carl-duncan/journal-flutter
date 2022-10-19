import 'package:flutter/material.dart';
import 'package:journal/home/widgets/home_entry_tile.dart';
import 'package:journal/home/widgets/home_entry_title.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal_api/journal_api.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key, required this.title, required this.entries});
  final String title;
  final List<Entry> entries;

  @override
  Widget build(BuildContext context) {
    final i10n = AppLocalizations.of(context);
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: HomeEntryTitle(
            title: title,
            subtitle: '${entries.length} ${i10n.entries}',
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
                  date: entries[index].createdAt!,
                  title: '${entries[index].title} ',
                  subtitle: entries[index].body,
                ),
              );
            },
            childCount: entries.length,
          ),
        ),
      ],
    );
  }
}
