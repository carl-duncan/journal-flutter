import 'package:flutter/material.dart';

class HomeIsland extends StatelessWidget {
  const HomeIsland({
    super.key,
    required this.onAddPressed,
    required this.onSearchPressed,
    required this.onSettingsPressed,
    required this.isSearchBarVisible,
    required this.onLockPressed,
    required this.isLocked,
  });

  final VoidCallback onAddPressed;

  final VoidCallback onSearchPressed;

  final VoidCallback onSettingsPressed;

  final VoidCallback onLockPressed;

  final bool isSearchBarVisible;

  final bool isLocked;

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
                height: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(0),
                ),
                // create 3 icons
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: onAddPressed,
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: onSearchPressed,
                      child: Icon(
                        size: 30,
                        isSearchBarVisible ? Icons.close : Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: onLockPressed,
                      child: Icon(
                        isLocked ? Icons.lock : Icons.lock_open,
                        size: 30,
                        color: isLocked ? Colors.amber : Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: onSettingsPressed,
                      child: const Icon(
                        Icons.settings,
                        size: 30,
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
