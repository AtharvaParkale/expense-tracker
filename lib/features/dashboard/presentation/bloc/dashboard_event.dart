part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class GetExpensesByDateRangeEvent extends DashboardEvent {}
