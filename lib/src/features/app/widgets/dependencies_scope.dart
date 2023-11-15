import 'package:flutter/widgets.dart';
import 'package:tinder_like/src/features/matching/domain/repository/users_repository.dart';

enum AppDependencies { userRepository }

class DependenciesScope extends InheritedModel<AppDependencies> {
  final UsersRepository usersRepository;

  const DependenciesScope({
    required this.usersRepository,
    required super.child,
    super.key,
  });

  static DependenciesScope _of(BuildContext context, {bool listen = false, AppDependencies? dependency}) {
    final widget = listen
        ? InheritedModel.inheritFrom<DependenciesScope>(context, aspect: dependency)
        : context.getInheritedWidgetOfExactType<DependenciesScope>();

    if (widget == null) throw ArgumentError('No DependenciesScope is found in provided context', 'out-of-scope');

    return widget;
  }

  static UsersRepository usersRepositoryOf(BuildContext context, {bool listen = false}) {
    return _of(context, listen: listen, dependency: AppDependencies.userRepository).usersRepository;
  }

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => oldWidget.usersRepository != usersRepository;

  @override
  bool updateShouldNotifyDependent(
    DependenciesScope oldWidget,
    Set<AppDependencies> dependencies,
  ) {
    for (final dependency in dependencies) {
      switch (dependency) {
        case AppDependencies.userRepository:
          if (oldWidget.usersRepository != usersRepository) return true;
      }
    }

    return false;
  }
}
