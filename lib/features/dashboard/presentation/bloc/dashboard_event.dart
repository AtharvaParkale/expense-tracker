part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class GetExpensesByDateRangeEvent extends DashboardEvent {}

final class AddExpenseEvent extends DashboardEvent {
  final double amount;
  final String title;
  final String category;

  AddExpenseEvent({
    required this.amount,
    required this.title,
    required this.category,
  });
}
