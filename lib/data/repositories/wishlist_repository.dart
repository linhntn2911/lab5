import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../models/photo.dart';

part 'wishlist_repository.g.dart';

@riverpod
WishlistRepository wishlistRepository(Ref ref) => WishlistRepository();

class WishlistRepository {
  static const _table = 'Photo';
  static const _webStorageKey = 'wishlist_photos';
  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    final path = join(await getDatabasesPath(), 'photo_wishlist.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE $_table (
          id INTEGER PRIMARY KEY,
          album_id INTEGER NOT NULL,
          title TEXT NOT NULL,
          url TEXT NOT NULL,
          thumbnail_url TEXT NOT NULL
        )
      '''),
    );
    return _database!;
  }

  Future<List<Photo>> getAll() async {
    if (kIsWeb) return _getWebPhotos();
    final db = await _db;
    final rows = await db.query(_table, orderBy: 'id DESC');
    return rows.map(Photo.fromDatabase).toList(growable: false);
  }

  Future<Set<int>> getIds() async {
    if (kIsWeb) return (await _getWebPhotos()).map((photo) => photo.id).toSet();
    final db = await _db;
    final rows = await db.query(_table, columns: ['id']);
    return rows.map((row) => row['id'] as int).toSet();
  }

  Future<void> add(Photo photo) async {
    if (kIsWeb) {
      final photos = await _getWebPhotos();
      final index = photos.indexWhere((item) => item.id == photo.id);
      if (index >= 0) {
        photos[index] = photo;
      } else {
        photos.add(photo);
      }
      await _saveWebPhotos(photos);
      return;
    }
    final db = await _db;
    await db.insert(
      _table,
      photo.toDatabase(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> remove(int id) async {
    if (kIsWeb) {
      final photos = await _getWebPhotos();
      photos.removeWhere((photo) => photo.id == id);
      await _saveWebPhotos(photos);
      return;
    }
    final db = await _db;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Photo>> _getWebPhotos() async {
    final preferences = await SharedPreferences.getInstance();
    final saved = preferences.getString(_webStorageKey);
    if (saved == null) return [];
    final items = jsonDecode(saved) as List<dynamic>;
    return items
        .map((item) => Photo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveWebPhotos(List<Photo> photos) async {
    final preferences = await SharedPreferences.getInstance();
    final items = photos
        .map(
          (photo) => {
            'id': photo.id,
            'albumId': photo.albumId,
            'title': photo.title,
            'url': photo.url,
            'thumbnailUrl': photo.thumbnailUrl,
          },
        )
        .toList();
    await preferences.setString(_webStorageKey, jsonEncode(items));
  }
}
