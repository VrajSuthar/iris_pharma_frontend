import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/main_screen_desktop.dart';
import '../widgets/main_screen_mobile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (_) => MainScreenMobile(),
      desktop: (context) => MainScreenDesktop(),
    );
  }
}
