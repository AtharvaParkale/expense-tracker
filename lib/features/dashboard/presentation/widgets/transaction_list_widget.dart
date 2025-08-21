import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({super.key});

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

  ListView _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: _buildIcon(),
          title: Text(
            "Groceries",
            style: appTextTheme.bodyMedium?.copyWith(
              color: AppPallete.bgBlack,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          subtitle: Text(
            "Food",
            style: appTextTheme.bodySmall?.copyWith(
              color: AppPallete.greyColor,
              fontWeight: AppFontWeight.medium,
            ),
          ),
          trailing: Text(
            "- ₹500",
            style: appTextTheme.bodyMedium?.copyWith(
              color: Colors.redAccent,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        );
      },
    );
  }

  Container _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppPallete.primaryColor.withOpacity(0.15),
        // light purple bg
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
