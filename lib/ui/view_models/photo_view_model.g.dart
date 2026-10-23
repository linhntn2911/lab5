// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotoViewModel)
final photoViewModelProvider = PhotoViewModelProvider._();

final class PhotoViewModelProvider
    extends $AsyncNotifierProvider<PhotoViewModel, List<Photo>> {
  PhotoViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoViewModelHash();

  @$internal
  @override
  PhotoViewModel create() => PhotoViewModel();
}

String _$photoViewModelHash() => r'e2897891ff8b926db049f41d6a3632f2dafe7325';

abstract class _$PhotoViewModel extends $AsyncNotifier<List<Photo>> {
  FutureOr<List<Photo>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Photo>>, List<Photo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Photo>>, List<Photo>>,
              AsyncValue<List<Photo>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
