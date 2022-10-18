import 'package:flutter/material.dart';
import 'package:journal/home/cubit/cubit.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import 'package:journal/home/widgets/home_entry_title.dart';

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
        return const CustomScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 60, bottom: 50),
              sliver: SliverToBoxAdapter(
                child: HomeCategorySelector(category: HomeCategory.entries),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Spacers.hPagePadding),
              sliver: SliverToBoxAdapter(
                child: HomeEntryTitle(
                  title: 'February 2022',
                  subtitle: '2 entries',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
