import 'package:flutter/material.dart';

class SplashIntroDesktop extends StatelessWidget {
  const SplashIntroDesktop({
    super.key,
    required this.images,
    required this.controller,
    required this.page,
    required this.onPageChanged,
    required this.onGetStarted,
  });

  final List<String> images;
  final PageController controller;
  final int page;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
