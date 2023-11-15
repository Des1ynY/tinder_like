import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
class Company {
  final String name;
  final String? catchPhrase;
  final List<String>? _services;

  const Company({
    required this.name,
    this.catchPhrase,
    List<String>? services,
  }) : _services = services;

  List<String>? get services => _services != null ? List.unmodifiable(_services!) : null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Company) return false;

    return other.name == name &&
        other.catchPhrase == catchPhrase &&
        const UnorderedIterableEquality<String>().equals(other._services, _services);
  }
}
