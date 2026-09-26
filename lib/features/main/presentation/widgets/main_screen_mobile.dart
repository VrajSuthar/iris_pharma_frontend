import 'dart:ui';

import 'package:amazing_icons/broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../cart/presentation/widgets/cart/cart_mobile.dart';
import '../../../favorite/presentation/widgets/favorite/favorite_mobile.dart';
import '../../../home/presentation/widgets/home/home_mobile.dart';
import '../../../profile/presentation/widgets/profile/profile_mobile.dart';
import '../../providers/main_tab_provider.dart';

class MainScreenMobile extends ConsumerWidget {
  const MainScreenMobile({super.key});

  static const _tabs = [
    HomeMobile(),
    FavoriteMobile(),
    CartMobile(),
    ProfileMobile(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(mainTabControllerProvider);
    final notifier = ref.read(mainTabControllerProvider.notifier);

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _tabs),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: notifier.setTab,
              selectedItemColor: AppColors.primaryBlue,
              unselectedItemColor: AppColors.deepNavy.withValues(alpha: 0.4),
              selectedLabelStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(AmazingIconBroken.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AmazingIconBroken.heart),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AmazingIconBroken.bag2),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AmazingIconBroken.setting2),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
