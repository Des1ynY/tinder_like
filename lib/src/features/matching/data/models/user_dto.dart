import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_like/src/features/matching/data/models/company_dto.dart';
import 'package:tinder_like/src/features/matching/data/models/location_dto.dart';
import 'package:tinder_like/src/features/matching/domain/entities/contacts.dart';
import 'package:tinder_like/src/features/matching/domain/entities/user.dart';
import 'package:tinder_like/src/shared/utils/typedefs.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final UserId id;

  final String name;
  final String? username;

  final String? email;
  final String? phone;
  final String? website;

  final CompanyDto? company;
  final LocationDto? address;

  const UserDto({
    required this.id,
    required this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
    this.company,
    this.address,
  });

  factory UserDto.fromJson(Json json) => _$UserDtoFromJson(json);

  User toEntity() {
    final contacts = [
      if (email != null) email!,
      if (phone != null) phone!,
      if (website != null) website!,
    ];
    final details = [
      if (company != null) company!,
      if (address != null) address!,
    ];

    if (details.isEmpty && contacts.isEmpty) return User(id: id, name: name, username: username);

    return DetailedUser(
      id: id,
      name: name,
      username: username,
      company: company?.toEntity(),
      address: address?.toEntity(),
      contacts: contacts.isNotEmpty
          ? Contacts(
              email: email,
              phone: phone,
              website: website,
            )
          : null,
    );
  }
}
