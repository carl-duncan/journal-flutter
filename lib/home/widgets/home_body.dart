import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
class HomeBody extends StatefulWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final ScrollController _scrollController = ScrollController();
  var _scrollOffset = 0.0;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          _scrollOffset = -200;
        } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          _scrollOffset = 0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final entriesByMonth = _getEntriesByMonth(state.entries);
        return Stack(
          children: [
            CustomScrollBody(
              controller: _scrollController,
              isLoading: state.isLoading,
              slivers: [
                const SliverPadding(
                  padding: EdgeInsets.only(
                    top: 60,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: HomeCategorySelector(category: HomeCategory.entries),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacers.hPagePadding,
                    vertical: 25,
                  ),
                  sliver: state.showSearchBar
                      ? const SliverToBoxAdapter(
                          key: Key('search_bar'),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        )
                      : const SliverToBoxAdapter(
                          key: Key('no_search_bar'),
                          child: SizedBox.shrink(),
                        ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacers.hPagePadding,
                  ),
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
            ),
            AnimatedPositioned(
              bottom: 0,
              left: 100,
              right: 100,
              curve: Curves.bounceInOut,
              top: MediaQuery.of(context).size.height * 0.85 - _scrollOffset,
              duration: const Duration(milliseconds: 200),
              child: HomeIsland(
                onAddPressed: () {
                  log('onAddPressed');
                },
                onSearchPressed: () {
                  context.read<HomeCubit>().toggleSearchBar();
                },
                onSettingsPressed: () {
                  log('onSettingsPressed');
                },
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
