import 'package:meta/meta.dart';

typedef PhotoId = int;

@immutable
class Photo {
  final PhotoId id;

  final String url;
  final String? thumbnailUrl;

  final String? title;

  const Photo({
    required this.id,
    required this.url,
    this.thumbnailUrl,
    this.title,
  });

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Photo) return false;

    return other.id == id;
  }
}
