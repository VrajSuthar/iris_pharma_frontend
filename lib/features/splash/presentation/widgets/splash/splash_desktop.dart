import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashDesktop extends StatelessWidget {
  const SplashDesktop({super.key, required this.controller});

  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
