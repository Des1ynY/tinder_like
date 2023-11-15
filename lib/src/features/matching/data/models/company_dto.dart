import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_like/src/features/matching/domain/entities/company.dart';
import 'package:tinder_like/src/shared/utils/typedefs.dart';

part 'company_dto.g.dart';

@JsonSerializable()
class CompanyDto {
  final String name;
  final String? catchPhrase;
  final List<String>? services;

  const CompanyDto({
    required this.name,
    this.catchPhrase,
    this.services,
  });

  factory CompanyDto.fromJson(Json json) => _$CompanyDtoFromJson(json);

  Company toEntity() => Company(name: name, catchPhrase: catchPhrase, services: services);
}
