import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/core/utils/custom_page_router.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/pages/all_transactions_page.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';

class DashboardTransactionListWidget extends StatelessWidget {
  const DashboardTransactionListWidget({super.key, required this.expenses});

  final List<Expense>? expenses;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            TransactionListWidget(expenses: expenses),
          ],
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          "Daily Expenses",
          style: appTextTheme.titleMedium?.copyWith(
            color: AppPallete.bgBlack,
            fontWeight: AppFontWeight.semiBold,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRoute.route(
                AllTransactionsPage(expenses: expenses),
                PageRouteDirection.LEFT,
              ),
            );
          },
          child: Text(
            "See all",
            style: appTextTheme.titleMedium?.copyWith(
              color: AppPallete.primaryColor,
              fontWeight: AppFontWeight.semiBold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
