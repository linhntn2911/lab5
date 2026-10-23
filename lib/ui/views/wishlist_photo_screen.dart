import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/wishlist_view_model.dart';

class WishlistPhotoScreen extends ConsumerWidget {
  const WishlistPhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);
    return wishlist.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Không thể đọc SQLite: $error')),
      data: (photos) {
        if (photos.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border, size: 64),
                SizedBox(height: 12),
                Text('Chưa có Photo được quan tâm.'),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: photos.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final photo = photos[index];
            return Card(
              child: ListTile(
                leading: Image.network(
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
                title: Text(
                  photo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('Album ${photo.albumId} • ID ${photo.id}'),
                trailing: IconButton(
                  tooltip: 'Bỏ quan tâm',
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () => ref
                      .read(wishlistViewModelProvider.notifier)
                      .remove(photo.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
