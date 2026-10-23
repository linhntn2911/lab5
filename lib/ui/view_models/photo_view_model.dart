import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/photo.dart';
import '../../data/repositories/photo_api_repository.dart';

part 'photo_view_model.g.dart';

@riverpod
class PhotoViewModel extends _$PhotoViewModel {
  @override
  FutureOr<List<Photo>> build() =>
      ref.watch(photoApiRepositoryProvider).getPhotos();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(photoApiRepositoryProvider).getPhotos(),
    );
  }
}
