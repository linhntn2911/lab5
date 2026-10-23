import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/theme_view_model.dart';
import 'photo_list_screen.dart';
import 'wishlist_photo_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref
        .watch(themeViewModelProvider)
        .when(
          data: (mode) => mode,
          loading: () => ThemeMode.system,
          error: (_, _) => ThemeMode.system,
        );
    final titles = ['Danh sách Photo', 'Photo quan tâm'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_index]),
        actions: [
          PopupMenuButton<ThemeMode>(
            tooltip: 'Chế độ giao diện',
            initialValue: themeMode,
            onSelected: (mode) =>
                ref.read(themeViewModelProvider.notifier).setThemeMode(mode),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text('Theo hệ thống'),
              ),
              PopupMenuItem(value: ThemeMode.light, child: Text('Chế độ sáng')),
              PopupMenuItem(value: ThemeMode.dark, child: Text('Chế độ tối')),
            ],
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: const [PhotoListScreen(), WishlistPhotoScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Photo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
        ],
      ),
    );
  }
}
