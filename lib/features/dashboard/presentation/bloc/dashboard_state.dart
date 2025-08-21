part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class LoadingState extends DashboardState {}

final class NoDailyExpensesFoundState extends DashboardState {}

final class ErrorState extends DashboardState {
  ErrorState({required this.message});

  final String message;
}

final class DailyExpensesSuccessState extends DashboardState {
  DailyExpensesSuccessState({required this.expenses});

  final List<Expense> expenses;
}
