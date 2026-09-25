import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_intro_provider.g.dart';

class SplashIntroState {
  const SplashIntroState({required this.controller, required this.page});

  final PageController controller;
  final int page;
}

@riverpod
class SplashIntroController extends _$SplashIntroController {
  @override
  SplashIntroState build() {
    final controller = PageController();
    ref.onDispose(controller.dispose);
    return SplashIntroState(controller: controller, page: 0);
  }

  void setPage(int page) {
    state = SplashIntroState(controller: state.controller, page: page);
  }
}
