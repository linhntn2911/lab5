import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/photo.dart';
import '../../data/repositories/wishlist_repository.dart';

part 'wishlist_view_model.g.dart';

@riverpod
class WishlistViewModel extends _$WishlistViewModel {
  @override
  FutureOr<List<Photo>> build() =>
      ref.watch(wishlistRepositoryProvider).getAll();

  Future<void> remove(int id) async {
    await ref.read(wishlistRepositoryProvider).remove(id);
    ref.invalidateSelf();
    ref.invalidate(favoriteIdsProvider);
  }
}

@riverpod
class FavoriteIds extends _$FavoriteIds {
  @override
  FutureOr<Set<int>> build() => ref.watch(wishlistRepositoryProvider).getIds();

  Future<void> toggle(Photo photo) async {
    final ids = state.when(
      data: (value) => value,
      loading: () => <int>{},
      error: (_, _) => <int>{},
    );
    if (ids.contains(photo.id)) {
      await ref.read(wishlistRepositoryProvider).remove(photo.id);
    } else {
      await ref.read(wishlistRepositoryProvider).add(photo);
    }
    ref.invalidateSelf();
    ref.invalidate(wishlistViewModelProvider);
  }
}
