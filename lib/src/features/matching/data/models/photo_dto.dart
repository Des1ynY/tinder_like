import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_like/src/features/matching/domain/entities/photo.dart';
import 'package:tinder_like/src/shared/utils/typedefs.dart';

part 'photo_dto.g.dart';

typedef AlbumId = int;

@JsonSerializable()
class PhotoDto {
  final PhotoId id;
  final AlbumId albumId;

  final String url;
  final String? thumbnailUrl;

  final String? title;

  const PhotoDto({
    required this.id,
    required this.albumId,
    required this.url,
    this.thumbnailUrl,
    this.title,
  });

  factory PhotoDto.fromJson(Json json) => _$PhotoDtoFromJson(json);

  Photo toEntity() {
    return Photo(
      id: id,
      url: url,
      thumbnailUrl: thumbnailUrl,
      title: title,
    );
  }
}
