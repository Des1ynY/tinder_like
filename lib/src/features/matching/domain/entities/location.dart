import 'package:meta/meta.dart';

@immutable
class Location {
  final String city;
  final String street;
  final String suite;
  final String zipCode;

  final double latitude;
  final double longitude;

  const Location({
    required this.city,
    required this.street,
    required this.suite,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
  });

  String get displayAddress => '$city, $street, $suite, $zipCode';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Location) return false;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.suite == suite &&
        other.street == street &&
        other.city == city;
  }
}
