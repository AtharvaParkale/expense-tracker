part of '../init_dependencies.dart';

class StatisticsDependencies {
  static void initiateDependencies(GetIt serviceLocator) {
    serviceLocator.registerLazySingleton(
      () => StatisticsBloc(getAllExpenses: serviceLocator()),
    );
  }
}
