import 'package:flutter/material.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/widgets/navigation_bar.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/widgets/page_scope.dart';
import 'package:tinder_like/src/features/matching/widgets/pages/user_matching_page/widgets/users_list/users_list_builder.dart';
import 'package:tinder_like/src/shared/theme/spacing.dart';

class UserMatchingPage extends StatefulWidget {
  const UserMatchingPage({super.key});

  @override
  State<UserMatchingPage> createState() => _UserMatchingPageState();
}

class _UserMatchingPageState extends State<UserMatchingPage> {
  final _viewController = PageController();

  @override
  Widget build(BuildContext context) {
    return UserMatchingPageScope(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.medium, vertical: Spacing.large),
            child: Column(
              children: [
                Expanded(child: UsersListBuilder(viewController: _viewController)),
                const SizedBox(height: Spacing.medium),
                UsersNavigationBar(controller: _viewController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewController.dispose();
    super.dispose();
  }
}
