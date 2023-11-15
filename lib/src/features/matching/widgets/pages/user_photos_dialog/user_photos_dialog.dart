import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tinder_like/src/features/matching/domain/entities/photo.dart';
import 'package:tinder_like/src/shared/theme/spacing.dart';
import 'package:tinder_like/src/shared/widgets/image_placeholder.dart';

class UserPhotosDialog extends StatelessWidget {
  final List<Photo> photos;

  const UserPhotosDialog({required this.photos, super.key});

  static Future<void> show(BuildContext context, List<Photo> photos) {
    return showDialog<void>(
      context: context,
      builder: (context) => UserPhotosDialog(photos: photos),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GridView.builder(
        itemCount: photos.length,
        padding: const EdgeInsets.all(Spacing.medium),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: Spacing.medium,
          crossAxisSpacing: Spacing.medium,
        ),
        itemBuilder: (context, index) => CachedNetworkImage(
          imageUrl: photos.elementAt(index).thumbnailUrl ?? photos.elementAt(index).url,
          placeholder: (context, url) => const ImagePlaceholder(),
        ),
      ),
    );
  }
}
