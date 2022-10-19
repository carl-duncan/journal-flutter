import 'package:flutter/material.dart';

class HomeIsland extends StatelessWidget {
  const HomeIsland({
    super.key,
    required this.onAddPressed,
    required this.onSearchPressed,
    required this.onSettingsPressed,
  });

  final VoidCallback onAddPressed;

  final VoidCallback onSearchPressed;

  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(0),
                ),
                // create 3 icons
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: onAddPressed,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: onSearchPressed,
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: onSettingsPressed,
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
