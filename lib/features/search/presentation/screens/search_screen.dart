import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/search/search_desktop.dart';
import '../widgets/search/search_mobile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const SearchMobile(),
        desktop: (_) => const SearchDesktop(),
      ),
    );
  }
}
