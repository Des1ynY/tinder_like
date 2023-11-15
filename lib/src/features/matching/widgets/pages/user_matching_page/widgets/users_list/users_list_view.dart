import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_like/src/features/matching/domain/entities/user.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/bloc/users_bloc/users_bloc.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/widgets/user_list_tile/user_list_tile.dart';
import 'package:tinder_like/src/shared/utils/iterable_ext.dart';

class UsersListView extends StatefulWidget {
  final PageController controller;
  final List<User> users;

  const UsersListView({required this.controller, required this.users, super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  void _loadUserPhotos() {
    final currentPage = widget.controller.page?.toInt() ?? widget.controller.initialPage;
    final lastPage = widget.controller.lastPage;

    if (currentPage == lastPage) return;

    widget.controller.lastPage = currentPage;
    context.read<UsersBloc>().add(UsersBlocEvent.loadUserPhotos(widget.users.elementAtCircle(currentPage).id));
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_loadUserPhotos);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller,
      itemBuilder: (context, index) => UsersListTile(user: widget.users.elementAtCircle(index)),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_loadUserPhotos);
    super.dispose();
  }
}

extension on PageController {
  static final _lastPage = Expando<int>();
  int get lastPage => _lastPage[this] ?? initialPage;
  set lastPage(int value) {
    if (value.isNegative) throw ArgumentError.value(value, 'invalid-value', 'Previous page value cannot be negative');

    _lastPage[this] = value;
  }
}
