import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/photo.dart';

part 'photo_api_repository.g.dart';

@riverpod
PhotoApiRepository photoApiRepository(Ref ref) => PhotoApiRepository();

class PhotoApiRepository {
  static const _endpoint =
      'https://jsonplaceholder.typicode.com/photos?_limit=100';

  Future<List<Photo>> getPhotos() async {
    final response = await http.get(Uri.parse(_endpoint));
    if (response.statusCode != 200) {
      throw Exception(
        'Không thể tải danh sách Photo (${response.statusCode}).',
      );
    }
    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map((item) => Photo.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}
