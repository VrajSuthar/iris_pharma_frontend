// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

final class SettingsControllerProvider
    extends
        $NotifierProvider<
          SettingsController,
          ({bool darkMode, bool notifications})
        > {
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({bool darkMode, bool notifications}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<({bool darkMode, bool notifications})>(value),
    );
  }
}

String _$settingsControllerHash() =>
    r'6dcc66a7f96eaf1df57cb96582ca8a95d92c2043';

abstract class _$SettingsController
    extends $Notifier<({bool darkMode, bool notifications})> {
  ({bool darkMode, bool notifications}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({bool darkMode, bool notifications}),
              ({bool darkMode, bool notifications})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({bool darkMode, bool notifications}),
                ({bool darkMode, bool notifications})
              >,
              ({bool darkMode, bool notifications}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
