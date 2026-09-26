import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/favorite/favorite_desktop.dart';
import '../widgets/favorite/favorite_mobile.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const FavoriteMobile(),
        desktop: (_) => const FavoriteDesktop(),
      ),
    );
  }
}
