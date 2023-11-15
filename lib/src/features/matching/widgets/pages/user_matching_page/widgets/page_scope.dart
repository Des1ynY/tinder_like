import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_like/src/features/app/widgets/dependencies_scope.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/bloc/users_bloc/users_bloc.dart';
import 'package:tinder_like/src/shared/utils/error_util.dart';

class UserMatchingPageScope extends StatelessWidget {
  final Widget child;

  const UserMatchingPageScope({required this.child, super.key});

  void _handleError(BuildContext context, Object error) {
    if (context.read<UsersBloc>().state.users == null) return;

    final errorMessage = ErrorUtil.localeError(context, error);
    final snackBar = SnackBar(content: Text(errorMessage));

    ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final usersRepository = DependenciesScope.usersRepositoryOf(context, listen: true);

    return BlocProvider(
      create: (context) => UsersBloc(repository: usersRepository)..add(const UsersBlocEvent.loadUsers()),
      child: BlocListener<UsersBloc, UsersBlocState>(
        listenWhen: (prev, curr) => curr.maybeMap(error: (_) => true, orElse: (_) => false),
        listener: (context, state) => state.mapOrNull(
          error: (state) => _handleError(context, state.error),
        ),
        child: child,
      ),
    );
  }
}
