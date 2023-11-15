part of 'user_list_tile.dart';

class _UserName extends StatelessWidget {
  final String name;

  final String? username;
  final String? company;

  const _UserName({
    required this.name,
    this.username,
    this.company,
  });

  String get _displayName {
    if (username?.isNotEmpty ?? false) return '$name, "$username"';

    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _displayName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (company != null)
          Text(
            company!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}
