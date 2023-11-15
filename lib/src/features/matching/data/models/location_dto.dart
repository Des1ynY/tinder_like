import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_like/src/features/matching/domain/entities/location.dart';
import 'package:tinder_like/src/shared/utils/typedefs.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  final String city;
  final String street;
  final String suite;

  @JsonKey(name: 'zipcode')
  final String zipCode;
  final GeoDto geo;

  const LocationDto({
    required this.city,
    required this.street,
    required this.suite,
    required this.zipCode,
    required this.geo,
  });

  factory LocationDto.fromJson(Json json) => _$LocationDtoFromJson(json);

  Location toEntity() {
    return Location(
      city: city,
      street: street,
      suite: suite,
      zipCode: zipCode,
      latitude: geo.latitude,
      longitude: geo.latitude,
    );
  }
}

@JsonSerializable()
class GeoDto {
  @JsonKey(name: 'lat', fromJson: GeoDto.latitudeFromJson)
  final double latitude;

  @JsonKey(name: 'lng', fromJson: GeoDto.longitudeFromJson)
  final double longitude;

  const GeoDto({required this.latitude, required this.longitude});

  factory GeoDto.fromJson(Json json) => _$GeoDtoFromJson(json);

  static double latitudeFromJson(String value) => double.parse(value);
  static double longitudeFromJson(String value) => double.parse(value);
}
