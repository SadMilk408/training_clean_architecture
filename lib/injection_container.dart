import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/network.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_local_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_remote_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/repositories/users_list_repository_impl.dart';
import 'package:training_clean_architecture/features/users_list/domain/usecases/get_users_list.dart';

import 'features/users_list/domain/repositories/users_list_repository.dart';
import 'features/users_list/presentation/bloc/users_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Users List
  // Bloc
  sl.registerFactory(
    () => UsersListBloc(
      getUsersList: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUsersList(sl()));

  // Repository
  sl.registerLazySingleton<UsersListRepository>(
    () => UsersListRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UsersListRemoteDataSource>(
    () => UsersListRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<UsersListLocalDataSource>(
    () => UsersListLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
