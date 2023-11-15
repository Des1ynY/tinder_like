import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tinder_like/src/features/matching/domain/entities/contacts.dart';
import 'package:tinder_like/src/features/matching/domain/entities/location.dart';
import 'package:tinder_like/src/features/matching/domain/entities/photo.dart';
import 'package:tinder_like/src/features/matching/domain/entities/user.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_photos_dialog/user_photos_dialog.dart';
import 'package:tinder_like/src/shared/l10n/l10n.dart';
import 'package:tinder_like/src/shared/theme/spacing.dart';
import 'package:tinder_like/src/shared/widgets/image_placeholder.dart';

part 'user_image.dart';
part 'user_info.dart';
part 'user_name.dart';

class UsersListTile extends StatelessWidget {
  final User user;

  const UsersListTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: switch (user) {
              final UserWithPhotos user when user.photos.isNotEmpty => _UserImage(photos: user.photos),
              _ => const _UserImagePlaceholder(),
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.medium, Spacing.medium, Spacing.medium, 0),
            child: _UserName(
              name: user.name,
              username: user.username,
              company: switch (user) {
                final DetailedUser user => user.company?.name,
                _ => null,
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Spacing.medium),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 100),
              child: switch (user) {
                final DetailedUser user => _UserInfo(address: user.address, contacts: user.contacts),
                _ => const _UserInfoPlaceholder(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
