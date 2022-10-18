import 'package:flutter/material.dart';
import 'package:journal/home/home.dart';
import 'package:journal/res/spacers.dart';

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
                  const EdgeInsets.symmetric(horizontal: Spacers.hPagePadding)
                      .copyWith(bottom: 30),
              sliver: const SliverToBoxAdapter(
                child: HomeEntryTitle(
                  title: 'February 2022',
                  subtitle: '2 entries',
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Spacers.hPagePadding),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: HomeEntryTile(
                        date: DateTime(2022, 12, 4),
                        title: 'Lorem ipsum dolor ',
                        subtitle: 'Lorem ipsum dolor sit amet, '
                            'consectetur adipiscing elit. '
                            'Donec ac ex et tellus '
                            'facilisis ultricies sit.',
                      ),
                    );
                  },
                  childCount: 3,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
