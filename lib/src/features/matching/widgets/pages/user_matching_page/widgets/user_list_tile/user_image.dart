part of 'user_list_tile.dart';

class _UserImage extends StatelessWidget {
  final List<Photo> photos;

  const _UserImage({required this.photos});

  void _openPhotosDialog(BuildContext context) => UserPhotosDialog.show(context, photos);

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: CachedNetworkImageProvider(photos.first.url),
      fit: BoxFit.cover,
      child: InkWell(
        onTap: () => _openPhotosDialog(context),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _UserImagePlaceholder extends StatelessWidget {
  const _UserImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return ImagePlaceholder(
      child: Center(
        child: Icon(
          Icons.person_4,
          size: 64,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }
}
