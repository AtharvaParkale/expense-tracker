import 'package:expense_tracker_app/core/common/widgets/shimmer_widget.dart';
import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/daily_expense_summary.dart';
import 'package:flutter/material.dart';

class DashboardFloatingCard extends StatelessWidget {
  const DashboardFloatingCard({super.key, required this.dailyExpenseSummary});

  final DailyExpenseSummary? dailyExpenseSummary;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -75,
      left: 24,
      right: 24,

      child: ShimmerWidget(
        isLoading: dailyExpenseSummary == null,
        child: Card(
          elevation: dailyExpenseSummary == null ? 0 : 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.22,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                colors: [Color(0xFF4A55E2), Color(0xFF6A74F7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [_buildSectionOne(), _buildSectionTwo()],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildSectionTwo() {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _titleValueWidget(
                'Expenses',
                '${dailyExpenseSummary?.totalCount}',
              ),
            ),
            _buildDivider(),
            Expanded(
              child: _titleValueWidget(
                'Avg (Rs.)',
                '${dailyExpenseSummary?.average.toStringAsFixed(1)}',
              ),
            ),
            _buildDivider(),
            Expanded(
              child: _titleValueWidget(
                'Max  (Rs.)',
                '${dailyExpenseSummary?.max.toStringAsFixed(1)}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildSectionOne() {
    return Expanded(
      child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s spend summary',
              style: appTextTheme.bodySmall?.copyWith(
                color: AppPallete.whiteColor,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rs ${dailyExpenseSummary?.total.toStringAsFixed(2)}',
              style: appTextTheme.titleLarge?.copyWith(
                color: AppPallete.whiteColor,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildDivider() {
    return const SizedBox(
      height: 40, // height of divider
      child: VerticalDivider(
        color: AppPallete.whiteColor, // subtle color
        thickness: 0.8, // thin line
        width: 32, // spacing around divider
      ),
    );
  }

  Column _titleValueWidget(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: appTextTheme.bodySmall?.copyWith(
            color: AppPallete.whiteColor,
            fontWeight: AppFontWeight.semiBold,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        const SizedBox(height: 5),
        Text(
          value,
          style: appTextTheme.titleMedium?.copyWith(
            color: AppPallete.whiteColor,
            fontWeight: AppFontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
