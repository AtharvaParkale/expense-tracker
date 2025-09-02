part of '../init_dependencies.dart';

class DashboardDependencies {
  static void initiateDependencies(GetIt serviceLocator) {
    // Datasource
    serviceLocator
      ..registerFactory<DashBoardRemoteDataSource>(
        () => DashboardRemoteDatasourceImpl(serviceLocator()),
      )
      ..registerFactory<DashboardLocalDataSource>(
        () => DashboardLocalDatasourceImpl(),
      )
      // Repository
      ..registerFactory<DashboardRepository>(
        () => DashBoardRepositoryImpl(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ),
      )
      // UseCases
      ..registerFactory(() => GetAllExpenses(serviceLocator()))
      ..registerFactory(() => AddExpense(serviceLocator()))
      // Bloc
      ..registerLazySingleton(
        () => DashboardBloc(
          getExpensesByDateRange: serviceLocator(),
          addExpense: serviceLocator(),
        ),
      );
  }
}
