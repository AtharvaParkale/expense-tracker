part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  AuthDependencies.initiateDependencies(serviceLocator);

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}
