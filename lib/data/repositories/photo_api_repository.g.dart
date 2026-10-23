// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_api_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoApiRepository)
final photoApiRepositoryProvider = PhotoApiRepositoryProvider._();

final class PhotoApiRepositoryProvider
    extends
        $FunctionalProvider<
          PhotoApiRepository,
          PhotoApiRepository,
          PhotoApiRepository
        >
    with $Provider<PhotoApiRepository> {
  PhotoApiRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoApiRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoApiRepositoryHash();

  @$internal
  @override
  $ProviderElement<PhotoApiRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhotoApiRepository create(Ref ref) {
    return photoApiRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoApiRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoApiRepository>(value),
    );
  }
}

String _$photoApiRepositoryHash() =>
    r'a57e59194544054ff2a5e9e9260e2075a39edf87';
