part of 'users_bloc.dart';

sealed class UsersBlocEvent {
  const UsersBlocEvent();

  const factory UsersBlocEvent.loadUsers() = _LoadUsersEvent;

  const factory UsersBlocEvent.loadUserPhotos(UserId userId) = _LoadUserPhotosEvent;
}

class _LoadUsersEvent extends UsersBlocEvent {
  const _LoadUsersEvent();
}

class _LoadUserPhotosEvent extends UsersBlocEvent {
  final UserId userId;

  const _LoadUserPhotosEvent(this.userId);
}
