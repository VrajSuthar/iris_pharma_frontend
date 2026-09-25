import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Pure UI for the splash video. Holds no state of its own — [controller]
/// comes from the provider via the screen; null while loading.
class SplashMobile extends StatelessWidget {
  const SplashMobile({super.key, required this.controller});

  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;

    return controller == null
        ? const SizedBox.shrink()
        : SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            ),
          );
  }
}
