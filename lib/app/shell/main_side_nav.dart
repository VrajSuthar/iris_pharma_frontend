import 'package:flutter/material.dart';

import 'main_nav_items.dart';

/// Side navigation for tablet and desktop web.
class MainSideNav extends StatelessWidget {
  const MainSideNav({
    super.key,
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: onSelected,
      destinations: [
        for (final item in mainNavItems)
          NavigationRailDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: const SizedBox.shrink(),
          ),
      ],
    );
  }
}
