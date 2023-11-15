import 'package:meta/meta.dart';

@immutable
class Contacts {
  final String? email;
  final String? phone;
  final String? website;

  const Contacts({
    this.email,
    this.phone,
    this.website,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Contacts) return false;

    return other.email == email && other.phone == phone && other.website == website;
  }
}
