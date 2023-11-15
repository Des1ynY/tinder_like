import 'package:meta/meta.dart';
import 'package:tinder_like/src/features/matching/domain/entities/company.dart';
import 'package:tinder_like/src/features/matching/domain/entities/contacts.dart';
import 'package:tinder_like/src/features/matching/domain/entities/location.dart';
import 'package:tinder_like/src/features/matching/domain/entities/photo.dart';

typedef UserId = int;

@immutable
class User {
  final UserId id;

  final String name;
  final String? username;

  const User({
    required this.id,
    required this.name,
    this.username,
  });

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! User) return false;

    return other.id == id;
  }
}

@immutable
class DetailedUser extends User {
  final Contacts? contacts;
  final Company? company;
  final Location? address;

  const DetailedUser({
    required super.id,
    required super.name,
    super.username,
    this.contacts,
    this.company,
    this.address,
  });

  factory DetailedUser.fromUser(
    User user, {
    Contacts? contacts,
    Company? company,
    Location? address,
  }) {
    return DetailedUser(
      id: user.id,
      name: user.name,
      username: user.username,
      contacts: contacts,
      company: company,
      address: address,
    );
  }
}

mixin UserWithPhotos on User {
  List<Photo> get photos;
}
