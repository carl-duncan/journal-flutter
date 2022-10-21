import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:journal/home/home.dart';
import 'package:journal/home/widgets/editor_modal.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/spacers.dart';
import 'package:journal/res/utils/transition.dart' show createRoute;
import 'package:journal/res/widgets/custom_scroll_body.dart';
import 'package:journal/settings/view/settings_page.dart';
import 'package:journal_api/journal_api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  final TextEditingController _editorController = TextEditingController();
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
  void dispose() {
    _scrollController.dispose();
    _editorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final l10n = context.l10n;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final entriesByMonth = _getEntriesByMonth(state.entries);
        return Stack(
          children: [
            CustomScrollBody(
              controller: _scrollController,
              isLoading: state.isLoading,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 60,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: HomeCategorySelector(
                      category: state.category,
                      onEntriesPressed: () => cubit.toggleCategory(
                        HomeCategory.entries,
                      ),
                      onGalleryPressed: () => cubit.toggleCategory(
                        HomeCategory.gallery,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacers.hPagePadding,
                    vertical: 25,
                  ),
                  sliver: state.showSearchBar
                      ? SliverToBoxAdapter(
                          key: const Key('search_bar'),
                          child: TextField(
                            autofocus: true,
                            onChanged: cubit.searchEntries,
                            decoration: InputDecoration(
                              hintText: l10n.search,
                              prefixIcon: const Icon(Icons.search),
                            ),
                          ),
                        )
                      : const SliverToBoxAdapter(
                          key: Key('no_search_bar'),
                          child: SizedBox.shrink(),
                        ),
                ),
                if (state.category == HomeCategory.entries)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacers.hPagePadding,
                    ),
                    sliver: MultiSliver(
                      children: entriesByMonth.entries.map((entry) {
                        return HomeSection(
                          title: entry.key,
                          entries: entry.value,
                          onEntryTileTap: (Entry entry) {
                            _editorController.text =
                                '${entry.title} ${entry.body}';
                            _toggleEditor(cubit, () {
                              cubit.updateEntry(entry, _editorController.text);
                            });
                          },
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
                  _toggleEditor(cubit, () {
                    cubit.createEntry(_editorController.text);
                  });
                },
                onSearchPressed: cubit.toggleSearchBar,
                onSettingsPressed: () {
                  Navigator.push(context, createRoute(const SettingsPage()));
                },
                isSearchBarVisible: state.showSearchBar,
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleEditor(HomeCubit cubit, VoidCallback onSave) {
    showBarModalBottomSheet<EditorModal>(
      useRootNavigator: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      animationCurve: Curves.easeInOut,
      builder: (context) => EditorModal(
        onSave: () {
          Navigator.pop(context);
          onSave();
        },
        onClose: () {
          Navigator.pop(context);
          _editorController.clear();
        },
        controller: _editorController,
      ),
    );
  }

  Map<String, List<Entry>> _getEntriesByMonth(List<Entry> entries) {
    final entriesByMonth = <String, List<Entry>>{};
    for (final entry in entries) {
      final key = DateFormat.MMMM(
        Localizations.localeOf(context).languageCode,
      ).add_y().format(entry.createdAt!);
      if (entriesByMonth.containsKey(key)) {
        entriesByMonth[key]!.add(entry);
      } else {
        entriesByMonth[key] = [entry];
      }
    }
    return entriesByMonth;
  }
}
