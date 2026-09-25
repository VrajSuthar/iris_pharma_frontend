import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/forgot_password_screen_desktop.dart';
import '../widgets/forgot_password_screen_mobile.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const ForgotPasswordScreenMobile(),
        desktop: (_) => const ForgotPasswordScreenDesktop(),
      ),
    );
  }
}
