// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MainTabController)
final mainTabControllerProvider = MainTabControllerProvider._();

final class MainTabControllerProvider
    extends $NotifierProvider<MainTabController, int> {
  MainTabControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainTabControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainTabControllerHash();

  @$internal
  @override
  MainTabController create() => MainTabController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mainTabControllerHash() => r'3c1bd826adc13907bd09909f4bde6654d2c6c917';

abstract class _$MainTabController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
