import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/profile/profile_desktop.dart';
import '../widgets/profile/profile_mobile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const ProfileMobile(),
        desktop: (_) => const ProfileDesktop(),
      ),
    );
  }
}
