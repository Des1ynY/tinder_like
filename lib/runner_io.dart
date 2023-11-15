import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as concurrency;
import 'package:flutter/widgets.dart';
import 'package:tinder_like/src/features/app/widgets/app.dart';
import 'package:tinder_like/src/features/app/widgets/dependencies_scope.dart';
import 'package:tinder_like/src/features/matching/data/repository/users_repository.dart';
import 'package:tinder_like/src/shared/http/http_client.dart';

Future<void> $initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized().deferFirstFrame();

  // Configuring app
  Bloc.transformer = concurrency.sequential();

  // Initializing dependencies
  const httpClient = HttpClient(host: 'jsonplaceholder.typicode.com');
  const usersRepository = UsersRepositoryImpl(client: httpClient);

  // Launching app
  runApp(
    const DependenciesScope(
      usersRepository: usersRepository,
      child: TinderLikeApp(),
    ),
  );
}
