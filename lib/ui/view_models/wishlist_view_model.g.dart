// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WishlistViewModel)
final wishlistViewModelProvider = WishlistViewModelProvider._();

final class WishlistViewModelProvider
    extends $AsyncNotifierProvider<WishlistViewModel, List<Photo>> {
  WishlistViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistViewModelHash();

  @$internal
  @override
  WishlistViewModel create() => WishlistViewModel();
}

String _$wishlistViewModelHash() => r'1906d3807f10a12098f9acb5a9e21142fdf25ee7';

abstract class _$WishlistViewModel extends $AsyncNotifier<List<Photo>> {
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

@ProviderFor(FavoriteIds)
final favoriteIdsProvider = FavoriteIdsProvider._();

final class FavoriteIdsProvider
    extends $AsyncNotifierProvider<FavoriteIds, Set<int>> {
  FavoriteIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteIdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteIdsHash();

  @$internal
  @override
  FavoriteIds create() => FavoriteIds();
}

String _$favoriteIdsHash() => r'035ce3928865add447e1c013b76826a8ca28095b';

abstract class _$FavoriteIds extends $AsyncNotifier<Set<int>> {
  FutureOr<Set<int>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Set<int>>, Set<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Set<int>>, Set<int>>,
              AsyncValue<Set<int>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
