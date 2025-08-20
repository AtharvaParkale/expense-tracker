part of '../init_dependencies.dart';

class AuthDependencies {
  static void initiateDependencies(GetIt serviceLocator) {
    serviceLocator
      ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()),
      )
      // Repository
      ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
      )
      // Usecases
      ..registerFactory(() => UserSignUp(serviceLocator()))
      ..registerFactory(() => UserLogin(serviceLocator()))
      ..registerFactory(() => CurrentUser(serviceLocator()))
      // Bloc
      ..registerLazySingleton(
        () => AuthBloc(
          userSignUp: serviceLocator(),
          userLogin: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ),
      );
  }
}
