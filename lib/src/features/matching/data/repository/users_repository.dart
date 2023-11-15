import 'dart:convert';

import 'package:tinder_like/src/features/matching/data/models/photo_dto.dart';
import 'package:tinder_like/src/features/matching/data/models/user_dto.dart';
import 'package:tinder_like/src/features/matching/domain/entities/photo.dart';
import 'package:tinder_like/src/features/matching/domain/entities/user.dart';
import 'package:tinder_like/src/features/matching/domain/repository/users_repository.dart';
import 'package:tinder_like/src/shared/http/http_client.dart';
import 'package:tinder_like/src/shared/utils/iterable_ext.dart';
import 'package:tinder_like/src/shared/utils/typedefs.dart';

class UsersRepositoryImpl implements UsersRepository {
  final HttpClient _client;

  const UsersRepositoryImpl({required HttpClient client}) : _client = client;

  @override
  Future<List<User>> getUsers() async {
    final response = await _client.get(
      path: '/users',
      converter: (response) => List.castFrom<dynamic, Json>(json.decode(response) as List<dynamic>),
    );

    return response.safeMap((e) => UserDto.fromJson(e).toEntity()).toList();
  }

  @override
  Future<List<Photo>> getUserPhotos(UserId userId) async {
    final albumsResponse = await _client.get(
      path: '/albums',
      queryParameters: {'userId': userId.toString()},
      converter: (response) => List.castFrom<dynamic, Json>(json.decode(response) as List<dynamic>),
    );
    final albumIds = albumsResponse.safeMap((e) => e['id'] as AlbumId);

    final queryBuffer = StringBuffer();
    for (int i = 0; i < albumIds.length; i++) {
      queryBuffer.write('albumId=${albumIds.elementAt(i)}');
      if (i != albumIds.length - 1) queryBuffer.write('&');
    }

    final photosResponse = await _client.get(
      path: '/photos',
      query: queryBuffer.toString(),
      converter: (response) => List.castFrom<dynamic, Json>(json.decode(response) as List<dynamic>),
    );

    return photosResponse.safeMap((e) => PhotoDto.fromJson(e).toEntity()).toList();
  }
}
