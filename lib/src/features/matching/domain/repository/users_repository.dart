import 'package:tinder_like/src/features/matching/domain/entities/photo.dart';
import 'package:tinder_like/src/features/matching/domain/entities/user.dart';

abstract interface class UsersRepository {
  Future<List<User>> getUsers();

  Future<List<Photo>> getUserPhotos(UserId userId);
}
