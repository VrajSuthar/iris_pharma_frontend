// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_intro_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SplashIntroController)
final splashIntroControllerProvider = SplashIntroControllerProvider._();

final class SplashIntroControllerProvider
    extends $NotifierProvider<SplashIntroController, SplashIntroState> {
  SplashIntroControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashIntroControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashIntroControllerHash();

  @$internal
  @override
  SplashIntroController create() => SplashIntroController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SplashIntroState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SplashIntroState>(value),
    );
  }
}

String _$splashIntroControllerHash() =>
    r'6519ee63b30c0d227896d307e5be871b8d2f5a18';

abstract class _$SplashIntroController extends $Notifier<SplashIntroState> {
  SplashIntroState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SplashIntroState, SplashIntroState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SplashIntroState, SplashIntroState>,
              SplashIntroState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
