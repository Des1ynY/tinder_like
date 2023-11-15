import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/bloc/users_bloc/users_bloc.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/widgets/users_list/users_list_view.dart';
import 'package:tinder_like/src/shared/l10n/l10n.dart';
import 'package:tinder_like/src/shared/utils/error_util.dart';

class UsersListBuilder extends StatelessWidget {
  final PageController viewController;

  const UsersListBuilder({required this.viewController, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersBlocState>(
      builder: (context, state) {
        final users = state.users;

        if (users == null) return state.isProcessing ? const _ProcessingView() : _ErrorView(Exception('No data'));
        if (users.isEmpty) return const _EmptyDataView();

        return UsersListView(controller: viewController, users: users);
      },
    );
  }
}

class _ProcessingView extends StatelessWidget {
  const _ProcessingView();

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator.adaptive());
}

class _EmptyDataView extends StatelessWidget {
  const _EmptyDataView();

  @override
  Widget build(BuildContext context) => Center(child: Text(context.locales.users_matching_no_data));
}

class _ErrorView extends StatelessWidget {
  final Object error;

  const _ErrorView(this.error);

  @override
  Widget build(BuildContext context) => Center(child: Text(ErrorUtil.localeError(context, error)));
}
