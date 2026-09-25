// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SplashVideoController)
final splashVideoControllerProvider = SplashVideoControllerProvider._();

final class SplashVideoControllerProvider
    extends $AsyncNotifierProvider<SplashVideoController, SplashVideoState> {
  SplashVideoControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashVideoControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashVideoControllerHash();

  @$internal
  @override
  SplashVideoController create() => SplashVideoController();
}

String _$splashVideoControllerHash() =>
    r'c9e59a7b58a37dc06263c26643c40d384efbeecf';

abstract class _$SplashVideoController
    extends $AsyncNotifier<SplashVideoState> {
  FutureOr<SplashVideoState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SplashVideoState>, SplashVideoState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SplashVideoState>, SplashVideoState>,
              AsyncValue<SplashVideoState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
