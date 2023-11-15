import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as concurrency;
import 'package:meta/meta.dart';
import 'package:tinder_like/src/features/matching/domain/entities/photo.dart';
import 'package:tinder_like/src/features/matching/domain/entities/user.dart';
import 'package:tinder_like/src/features/matching/domain/repository/users_repository.dart';

part 'users_bloc_entities.dart';
part 'users_bloc_event.dart';
part 'users_bloc_state.dart';

typedef _Emit = Emitter<UsersBlocState>;

class UsersBloc extends Bloc<UsersBlocEvent, UsersBlocState> {
  final UsersRepository _repository;

  UsersBloc({required UsersRepository repository})
      : _repository = repository,
        super(const _Idle()) {
    on<_LoadUsersEvent>(_loadUsers);
    on<_LoadUserPhotosEvent>(_loadUserPhotos, transformer: concurrency.concurrent());
  }

  Future<void> _loadUsers(_LoadUsersEvent event, _Emit emit) async {
    emit(_Processing(users: state.users));

    try {
      final users = await _repository.getUsers();
      if (users.isNotEmpty) add(UsersBlocEvent.loadUserPhotos(users.first.id));

      emit(_Success(users: users));
    } on Object catch (e, st) {
      addError(e, st);
      emit(_Error(error: e, users: state.users));
    } finally {
      emit(_Idle(users: state.users));
    }
  }

  Future<void> _loadUserPhotos(_LoadUserPhotosEvent event, _Emit emit) async {
    emit(_Processing(users: state.users));

    try {
      final users = [...?state.users];
      final relatedUserIndex = users.indexWhere((e) => e.id == event.userId);
      final relatedUser = state.users!.elementAtOrNull(relatedUserIndex);

      if (relatedUser != null && relatedUser is! UserWithPhotos) {
        final photos = await _repository.getUserPhotos(event.userId);

        if (photos.isNotEmpty) {
          final updatedUser = switch (relatedUser) {
            final DetailedUser user => _DetailedUserWithPhotos.fromUser(user, photos),
            _ => _UserWithPhotos.fromUser(relatedUser, photos),
          };
          users.replaceRange(relatedUserIndex, relatedUserIndex + 1, [updatedUser]);
        }

        emit(_Success(users: users));
      }
    } on Object catch (e, st) {
      addError(e, st);
      emit(_Error(error: e, users: state.users));
    } finally {
      emit(_Idle(users: state.users));
    }
  }
}
