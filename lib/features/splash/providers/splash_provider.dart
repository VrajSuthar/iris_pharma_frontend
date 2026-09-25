import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

part 'splash_provider.g.dart';

class SplashVideoState {
  const SplashVideoState({required this.controller, this.isFinished = false});

  final VideoPlayerController controller;
  final bool isFinished;
}

@riverpod
class SplashVideoController extends _$SplashVideoController {
  @override
  Future<SplashVideoState> build() async {
    final controller = VideoPlayerController.asset(
      'assets/video/iris_pharma_splash_video.mp4',
    );
    ref.onDispose(controller.dispose);

    await controller.initialize();
    controller.addListener(_checkCompletion);
    await controller.play();

    return SplashVideoState(controller: controller);
  }

  void _checkCompletion() {
    final current = state.value;
    if (current == null || current.isFinished) return;

    final value = current.controller.value;
    if (value.isInitialized &&
        value.position >= value.duration &&
        !value.isPlaying) {
      state = AsyncData(
        SplashVideoState(controller: current.controller, isFinished: true),
      );
    }
  }
}
