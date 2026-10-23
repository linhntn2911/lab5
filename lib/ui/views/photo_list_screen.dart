import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/photo_view_model.dart';
import '../view_models/wishlist_view_model.dart';

class PhotoListScreen extends ConsumerWidget {
  const PhotoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photos = ref.watch(photoViewModelProvider);
    final favoriteIds = ref
        .watch(favoriteIdsProvider)
        .when(
          data: (ids) => ids,
          loading: () => const <int>{},
          error: (_, _) => const <int>{},
        );

    return photos.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _LoadError(
        message: error.toString(),
        onRetry: () => ref.read(photoViewModelProvider.notifier).refresh(),
      ),
      data: (items) => RefreshIndicator(
        onRefresh: () => ref.read(photoViewModelProvider.notifier).refresh(),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final photo = items[index];
            final isFavorite = favoriteIds.contains(photo.id);
            return Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: Hero(
                  tag: 'photo-${photo.id}',
                  child: Image.network(
                    photo.thumbnailUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
                title: Text(
                  photo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('Album ${photo.albumId} • ID ${photo.id}'),
                trailing: IconButton(
                  tooltip: isFavorite ? 'Bỏ quan tâm' : 'Quan tâm',
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: isFavorite ? Colors.red : null,
                  onPressed: () =>
                      ref.read(favoriteIdsProvider.notifier).toggle(photo),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off_outlined, size: 48),
          const SizedBox(height: 12),
          Text(
            'Không thể tải Photo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ],
      ),
    ),
  );
}
