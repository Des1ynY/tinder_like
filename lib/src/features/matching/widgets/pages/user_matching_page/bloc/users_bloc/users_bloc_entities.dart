part of 'users_bloc.dart';

@immutable
class _UserWithPhotos extends User with UserWithPhotos {
  final List<Photo> _photos;

  const _UserWithPhotos({
    required super.id,
    required super.name,
    required List<Photo> photos,
    super.username,
  }) : _photos = photos;

  factory _UserWithPhotos.fromUser(User user, List<Photo> photos) {
    return _UserWithPhotos(
      id: user.id,
      name: user.name,
      photos: photos,
      username: user.username,
    );
  }

  @override
  List<Photo> get photos => List.unmodifiable(_photos);
}

@immutable
class _DetailedUserWithPhotos extends DetailedUser with UserWithPhotos {
  final List<Photo> _photos;

  const _DetailedUserWithPhotos({
    required super.id,
    required super.name,
    required List<Photo> photos,
    super.username,
    super.contacts,
    super.company,
    super.address,
  }) : _photos = photos;

  factory _DetailedUserWithPhotos.fromUser(DetailedUser user, List<Photo> photos) {
    return _DetailedUserWithPhotos(
      id: user.id,
      name: user.name,
      photos: photos,
      username: user.username,
      contacts: user.contacts,
      company: user.company,
      address: user.address,
    );
  }

  @override
  List<Photo> get photos => List.unmodifiable(_photos);
}
