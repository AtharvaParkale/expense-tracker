import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Expense> _dailyExpenses = [];

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetExpensesByDateRangeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DailyExpensesSuccessState) {
            _dailyExpenses = state.expenses;
          }
        },
        buildWhen: (prev, curr) =>
            curr is LoadingState ||
            curr is ErrorState ||
            curr is NoDailyExpensesFoundState ||
            curr is DailyExpensesSuccessState,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: Text("Loading today's expenses..."));
          } else if (state is ErrorState) {
            return const Center(
              child: Text("Something went wrong. Please try again."),
            );
          } else if (state is NoDailyExpensesFoundState) {
            return const Center(child: Text("No expenses found for today."));
          } else if (state is DailyExpensesSuccessState) {
            return Center(
              child: Text(
                "Expenses loaded successfully! 🎉 ${_dailyExpenses.length}",
              ),
            );
          } else {
            return const Center(child: Text("Dashboard screen"));
          }
        },
      ),
    );
  }
}
