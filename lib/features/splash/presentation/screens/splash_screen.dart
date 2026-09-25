import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/responsive/responsive_builder.dart';
import '../../providers/splash_provider.dart';
import '../widgets/splash/splash_desktop.dart';
import '../widgets/splash/splash_mobile.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashVideoControllerProvider, (previous, next) {
      if (next.value?.isFinished == true) {
        context.go(RoutePaths.splashIntro);
      }
    });

    final controller = ref.watch(splashVideoControllerProvider).value?.controller;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ResponsiveBuilder(
        mobile: (_) => SplashMobile(controller: controller),
        desktop: (_) => SplashDesktop(controller: controller),
      ),
    );
  }
}
