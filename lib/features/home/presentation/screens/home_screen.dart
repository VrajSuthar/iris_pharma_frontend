import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/home/home_desktop.dart';
import '../widgets/home/home_mobile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const HomeMobile(),
        desktop: (_) => const HomeDesktop(),
      ),
    );
  }
}
