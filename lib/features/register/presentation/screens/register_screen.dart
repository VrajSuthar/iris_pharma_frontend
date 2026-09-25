import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/register_screen_desktop.dart';
import '../widgets/register_screen_mobile.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const RegisterScreenMobile(),
        desktop: (_) => const RegisterScreenDesktop(),
      ),
    );
  }
}
