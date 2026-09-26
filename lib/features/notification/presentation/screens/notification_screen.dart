import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_builder.dart';
import '../widgets/notification/notification_desktop.dart';
import '../widgets/notification/notification_mobile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => const NotificationMobile(),
        desktop: (_) => const NotificationDesktop(),
      ),
    );
  }
}
