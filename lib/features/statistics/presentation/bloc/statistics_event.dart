part of 'statistics_bloc.dart';

@immutable
sealed class StatisticsEvent {}

final class GetAllTheExpensesEvent extends StatisticsEvent {}
