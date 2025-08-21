import 'package:expense_tracker_app/core/common/widgets/shimmer_widget.dart';
import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/core/utils/common_methods.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({super.key, required this.expenses});

  final List<Expense>? expenses;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), _buildList()],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ShimmerWidget(
      isLoading: expenses == null,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: expenses == null
            ? CommonMethods.dummyExpenses.length
            : expenses?.length,
        itemBuilder: (context, index) {
          final expense = expenses == null
              ? CommonMethods.dummyExpenses[index]
              : expenses?[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _buildTile(expense),
          );
        },
      ),
    );
  }

  Row _buildTile(Expense? expense) {
    return Row(
      children: [
        _buildIcon(),
        const SizedBox(width: 12),
        _buildHeaderSection(expense),
        const SizedBox(width: 5),
        _buildAmountWidget(expense),
      ],
    );
  }

  Text _buildAmountWidget(Expense? expense) {
    return Text(
      expense?.amount.toStringAsFixed(1) ?? "",
      style: appTextTheme.bodyMedium?.copyWith(
        color: Colors.redAccent,
        fontWeight: AppFontWeight.semiBold,
      ),
    );
  }

  Expanded _buildHeaderSection(Expense? expense) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense?.title ?? "",
            style: appTextTheme.bodyMedium?.copyWith(
              color: AppPallete.bgBlack,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            expense?.category ?? "",
            style: appTextTheme.bodySmall?.copyWith(
              color: AppPallete.greyColor,
              fontWeight: AppFontWeight.medium,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppPallete.primaryColor.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        color: AppPallete.primaryColor,
        size: 20,
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: [
        Text(
          "Daily Transactions",
          style: appTextTheme.titleMedium?.copyWith(
            color: AppPallete.bgBlack,
            fontWeight: AppFontWeight.semiBold,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
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
