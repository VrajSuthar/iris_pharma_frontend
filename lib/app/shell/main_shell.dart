import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/responsive/responsive_builder.dart';
import 'main_bottom_nav.dart';
import 'main_side_nav.dart';

/// Frame around the four main tabs: bottom bar on phones, side rail on wider screens.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _select(int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (context) => Scaffold(
        body: shell,
        bottomNavigationBar: MainBottomNav(
          currentIndex: shell.currentIndex,
          onSelected: _select,
        ),
      ),
      tablet: (context) => Scaffold(
        body: Row(
          children: [
            MainSideNav(currentIndex: shell.currentIndex, onSelected: _select),
            Expanded(child: shell),
          ],
        ),
      ),
    );
  }
}
