import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/categories/categories_desktop.dart';
import '../widgets/categories/categories_mobile.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const CategoriesMobile(),
        desktop: (_) => const CategoriesDesktop(),
      ),
    );
  }
}
