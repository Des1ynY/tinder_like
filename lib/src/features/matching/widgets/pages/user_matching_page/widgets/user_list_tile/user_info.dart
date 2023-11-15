part of 'user_list_tile.dart';

class _UserInfo extends StatelessWidget {
  final Location? address;
  final Contacts? contacts;

  const _UserInfo({
    required this.address,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (contacts != null) ...[
          if (contacts?.email != null)
            _UserInfoRow(
              title: context.locales.user_info_email,
              value: contacts!.email!,
            ),
          if (contacts?.phone != null)
            _UserInfoRow(
              title: context.locales.user_info_phone,
              value: contacts!.phone!,
            ),
          if (contacts?.email != null)
            _UserInfoRow(
              title: context.locales.user_info_website,
              value: contacts!.website!,
            ),
        ],
        if (address != null)
          _UserInfoRow(
            title: context.locales.user_info_address,
            value: address!.displayAddress,
          ),
      ],
    );
  }
}

class _UserInfoPlaceholder extends StatelessWidget {
  const _UserInfoPlaceholder();

  @override
  Widget build(BuildContext context) => Center(child: Text(context.locales.users_matching_no_data));
}

class _UserInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _UserInfoRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('•'),
        const SizedBox(width: Spacing.extraSmall),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$title: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
