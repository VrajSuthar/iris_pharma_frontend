import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/login_screen_desktop.dart';
import '../widgets/login_screen_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => LoginScreenMobile(),
        desktop: (_) => LoginScreenDesktop(),
      ),
    );
  }
}
