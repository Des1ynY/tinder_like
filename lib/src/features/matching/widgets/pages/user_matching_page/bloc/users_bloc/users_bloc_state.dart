// ignore_for_file: library_private_types_in_public_api

part of 'users_bloc.dart';

typedef UsersBlocStateMatch<T, S extends UsersBlocState> = T Function(S state);

@immutable
sealed class UsersBlocState {
  final List<User>? users;

  const UsersBlocState({this.users});

  bool get isProcessing => maybeMap(idle: (_) => false, orElse: (_) => true);

  T map<T>({
    required UsersBlocStateMatch<T, _Idle> idle,
    required UsersBlocStateMatch<T, _Processing> processing,
    required UsersBlocStateMatch<T, _Success> success,
    required UsersBlocStateMatch<T, _Error> error,
  }) {
    return switch (this) {
      final _Idle state => idle(state),
      final _Processing state => processing(state),
      final _Success state => success(state),
      final _Error state => error(state),
    };
  }

  T maybeMap<T>({
    required UsersBlocStateMatch<T, UsersBlocState> orElse,
    UsersBlocStateMatch<T, _Idle>? idle,
    UsersBlocStateMatch<T, _Processing>? processing,
    UsersBlocStateMatch<T, _Success>? success,
    UsersBlocStateMatch<T, _Error>? error,
  }) {
    return map(
      idle: idle ?? orElse,
      processing: processing ?? orElse,
      success: success ?? orElse,
      error: error ?? orElse,
    );
  }

  T? mapOrNull<T>({
    UsersBlocStateMatch<T, _Idle>? idle,
    UsersBlocStateMatch<T, _Processing>? processing,
    UsersBlocStateMatch<T, _Success>? success,
    UsersBlocStateMatch<T, _Error>? error,
  }) {
    return maybeMap(
      idle: idle,
      processing: processing,
      success: success,
      error: error,
      orElse: (_) => null,
    );
  }
}

class _Idle extends UsersBlocState {
  const _Idle({super.users});
}

class _Processing extends UsersBlocState {
  const _Processing({super.users});
}

class _Success extends UsersBlocState {
  const _Success({required List<User> super.users});

  @override
  List<User> get users => super.users!;
}

class _Error extends UsersBlocState {
  final Object error;

  const _Error({required this.error, super.users});
}
