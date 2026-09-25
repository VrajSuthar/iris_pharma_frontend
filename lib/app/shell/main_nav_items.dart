import 'package:flutter/material.dart';

/// One entry of the main navigation. Order matches the router branches.
class MainNavItem {
  const MainNavItem({required this.icon, required this.selectedIcon});

  final IconData icon;
  final IconData selectedIcon;
}

/// Owner: add labels and swap icons as you like.
const mainNavItems = [
  MainNavItem(icon: Icons.home_outlined, selectedIcon: Icons.home),
  MainNavItem(icon: Icons.grid_view_outlined, selectedIcon: Icons.grid_view),
  MainNavItem(
    icon: Icons.shopping_bag_outlined,
    selectedIcon: Icons.shopping_bag,
  ),
  MainNavItem(icon: Icons.person_outline, selectedIcon: Icons.person),
];
