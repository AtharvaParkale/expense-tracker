part of 'statistics_bloc.dart';

@immutable
sealed class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}

final class LoadingState extends StatisticsState {}

final class NoExpensesFoundState extends StatisticsState {}

final class ErrorState extends StatisticsState {
  ErrorState({required this.message});

  final String message;
}

final class AllExpensesSuccessState extends StatisticsState {
  AllExpensesSuccessState({required this.expenses});

  final List<Expense> expenses;
}
