import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/responsive/responsive_builder.dart';
import '../../providers/splash_intro_provider.dart';
import '../widgets/splash_intro/splash_intro_desktop.dart';
import '../widgets/splash_intro/splash_intro_mobile.dart';

class SplashIntroScreen extends ConsumerWidget {
  const SplashIntroScreen({super.key});

  static const _images = [
    'assets/jpg/splash_intro_1.jpg',
    'assets/jpg/splash_intro_2.jpg',
    'assets/jpg/splash_intro_3.jpg',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introState = ref.watch(splashIntroControllerProvider);
    final notifier = ref.read(splashIntroControllerProvider.notifier);

    return Scaffold(
      body: ResponsiveBuilder(
        mobile: (_) => SplashIntroMobile(
          images: _images,
          controller: introState.controller,
          page: introState.page,
          onPageChanged: notifier.setPage,
          onGetStarted: () => context.push(RoutePaths.login),
        ),
        desktop: (_) => SplashIntroDesktop(
          images: _images,
          controller: introState.controller,
          page: introState.page,
          onPageChanged: notifier.setPage,
          onGetStarted: () => context.push(RoutePaths.login),
        ),
      ),
    );
  }
}
