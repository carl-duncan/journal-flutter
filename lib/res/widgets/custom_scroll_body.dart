import 'package:flutter/material.dart';

class CustomScrollBody extends StatelessWidget {
  const CustomScrollBody({
    super.key,
    required this.slivers,
    required this.isLoading,
  });
  final List<Widget> slivers;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: slivers,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isLoading
              ? ColoredBox(
                  key: const ValueKey('loading'),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink(
                  key: ValueKey('not_loading'),
                ),
        ),
      ],
    );
  }
}
