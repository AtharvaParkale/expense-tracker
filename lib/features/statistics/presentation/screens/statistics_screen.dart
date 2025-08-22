import 'package:expense_tracker_app/core/common/widgets/app_bar_widget.dart';
import 'package:expense_tracker_app/core/common/widgets/shimmer_widget.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/utils/common_methods.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/widgets/no_transaction_widget.dart';
import 'package:expense_tracker_app/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:expense_tracker_app/features/statistics/presentation/widgets/category_pirchart_selector.dart';
import 'package:expense_tracker_app/features/statistics/presentation/widgets/monthly_spends_chart.dart';
import 'package:expense_tracker_app/features/statistics/presentation/widgets/weekly_expense_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<Expense> _allExpenses = [];

  @override
  void initState() {
    super.initState();
    context.read<StatisticsBloc>().add(GetAllTheExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Statistics"),
      backgroundColor: AppPallete.whiteColor,
      body: BlocConsumer<StatisticsBloc, StatisticsState>(
        listener: (context, state) {
          if (state is AllExpensesSuccessState) {
            _allExpenses = state.expenses;
          }
        },
        buildWhen: (prev, curr) => _buildWhen(curr),
        builder: (context, state) {
          if (state is ErrorState) {
            return ErrorWidget(state.message);
          } else if (state is LoadingState) {
            return _buildStatsList({}, context, true);
          } else if (state is AllExpensesSuccessState) {
            final grouped = CommonMethods.groupExpensesByWeek(_allExpenses);
            return _buildStatsList(grouped, context, false);
          } else if (state is NoExpensesFoundState) {
            return const NoTransactionWidget(
              title: "No expenses found to track",
            );
          } else {
            return const Text('No state', style: TextStyle(color: Colors.red));
          }
        },
      ),
    );
  }

  Container _buildStatsList(
    Map<String, List<Expense>> grouped,
    BuildContext context,
    bool isLoading,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            ShimmerWidget(
              isLoading: isLoading,
              child: WeeklyExpensesList(
                groupedExpenses: grouped,
                height: MediaQuery.of(context).size.height * 0.23,
              ),
            ),
            const SizedBox(height: 20),

            ShimmerWidget(
              isLoading: isLoading,
              child: MonthlySpendsChart(expenses: _allExpenses),
            ),

            const SizedBox(height: 20),

            ShimmerWidget(
              isLoading: isLoading,
              child: CategoryPieChartSelector(
                key: ValueKey(_allExpenses.length),
                expenses: _allExpenses,
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  bool _buildWhen(StatisticsState curr) {
    return curr is LoadingState ||
        curr is ErrorState ||
        curr is NoExpensesFoundState ||
        curr is AllExpensesSuccessState;
  }
}
