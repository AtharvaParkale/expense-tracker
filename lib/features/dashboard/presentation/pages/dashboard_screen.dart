import 'package:expense_tracker_app/core/common/widgets/app_bar_widget.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/widgets/base_ui_component_widget.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/widgets/dashboard_floating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Expense>? _dailyExpenses;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetExpensesByDateRangeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Hi there 👋"),
      backgroundColor: AppPallete.bgBlack,
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DailyExpensesSuccessState) {
            _dailyExpenses = state.dailyExpenseSummary.dailyExpenses;
          }
        },
        buildWhen: (prev, curr) => _buildWhen(curr),
        builder: (context, state) {
          if (state is DailyExpensesSuccessState) {
            return BaseUIComponentWidget(
              floatingWidget: DashboardFloatingCard(
                dailyExpenseSummary: state.dailyExpenseSummary,
              ),
            );
          } else {
            return const BaseUIComponentWidget(
              floatingWidget: DashboardFloatingCard(dailyExpenseSummary: null),
            );
          }
        },
      ),
    );
  }

  bool _buildWhen(DashboardState curr) {
    return curr is LoadingState ||
        curr is ErrorState ||
        curr is NoDailyExpensesFoundState ||
        curr is DailyExpensesSuccessState;
  }
}
