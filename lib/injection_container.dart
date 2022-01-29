import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivia_clean_architecture/core/network/network_info.dart';
import 'package:number_trivia_clean_architecture/core/util/input_converter.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/num_trivia_repository.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';

//* This file is used to inject dependencies
final sLocator = GetIt.instance;

Future<void> init() async {
  //NOTE: Features - Number Trivia
  //* BLoC
  //? Classes requiring cleanup like BLoCs should not registered as singletons
  sLocator.registerFactory(() => NumberTriviaBloc(
        concrete: sLocator(),
        random: sLocator(),
        converter: sLocator(),
      ));

  //* Use cases
  sLocator.registerLazySingleton(() => GetConcreteNumberTrivia(sLocator()));
  sLocator.registerLazySingleton(() => GetRandomNumberTrivia(sLocator()));

  //* Repository
  //? Cannot instantiate a depended contract (abstract class). Hence, instantiate the impl of the repo
  sLocator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sLocator(),
      localDataSource: sLocator(),
      networkInfo: sLocator(),
    ),
  );

  //* Data Sources
  sLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: sLocator()),
  );

  sLocator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sLocator()),
  );

  //NOTE: Core
  sLocator.registerLazySingleton(() => InputConverter());
  sLocator
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sLocator()));

  //NOTE: External
  final sharedPreferences = await SharedPreferences.getInstance();
  sLocator.registerLazySingleton(() => sharedPreferences);
  sLocator.registerLazySingleton(() => http.Client());
  sLocator.registerLazySingleton(() => DataConnectionChecker());
}
