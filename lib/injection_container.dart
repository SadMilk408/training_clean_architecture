import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_clean_architecture/core/network/network.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/check_user_info.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/get_users_info_list.dart';
import 'package:training_clean_architecture/features/user_info/domain/usecases/update_user_info.dart';
import 'package:training_clean_architecture/features/user_info/presentation/bloc/favorite_check_cubit/favorite_check_cubit.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_local_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/data_sources/users_list_remote_data_source.dart';
import 'package:training_clean_architecture/features/users_list/data/repositories/users_list_repository_impl.dart';
import 'package:training_clean_architecture/features/users_list/domain/usecases/get_users_list.dart';

import 'features/auth/data/data_sources/login_local_data_source.dart';
import 'features/auth/data/repositories/login_repository_impl.dart';
import 'features/auth/domain/repositories/login_repository.dart';
import 'features/auth/domain/usecases/get_login.dart';
import 'features/auth/domain/usecases/set_login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/user_info/data/ data_sources/user_info_local_data_source.dart';
import 'features/user_info/data/repositories/user_info_repository_impl.dart';
import 'features/user_info/domain/repositories/user_info_repository.dart';
import 'features/users_list/domain/repositories/users_list_repository.dart';
import 'features/users_list/presentation/bloc/users_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      getLogin: sl(),
      setLogin: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetLogin(sl()));
  sl.registerLazySingleton(() => SetLogin(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  /// Features - User Info
  sl.registerFactory(
    () => FavoriteCheckCubit(
      updateUserInfo: sl(),
      checkUserInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CheckUserInfo(sl()));
  sl.registerLazySingleton(() => GetUsersInfoList(sl()));
  sl.registerLazySingleton(() => UpdateUserInfo(sl()));

  // Repository
  sl.registerLazySingleton<UserInfoRepository>(
    () => UserInfoRepositoryImpl(
      localDataSource: sl(), localAllUsersDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserInfoLocalDataSource>(
    () => UserInfoLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  /// Features - Users List
  // Bloc
  sl.registerFactory(
    () => UsersListBloc(
      getUsersList: sl(),
      getUsersInfoList: sl(),
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
