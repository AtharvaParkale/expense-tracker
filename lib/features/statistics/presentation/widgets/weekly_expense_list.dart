import 'package:expense_tracker_app/core/common/widgets/card_widget.dart';
import 'package:expense_tracker_app/core/common/widgets/stat_title.dart';
import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class WeeklyExpensesList extends StatefulWidget {
  final Map<String, List<Expense>> groupedExpenses;
  final double height;

  const WeeklyExpensesList({
    super.key,
    required this.groupedExpenses,
    this.height = 200,
  });

  @override
  State<WeeklyExpensesList> createState() => _WeeklyExpensesListState();
}

class _WeeklyExpensesListState extends State<WeeklyExpensesList> {
  final Map<String, bool> _expanded = {};

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Column(
        children: [
          const StatTitle(title: "Weekly Breakdown"),
          const SizedBox(height: 15),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Scrollbar(
      thumbVisibility: true,
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView(
          children: widget.groupedExpenses.entries.map((entry) {
            final week = entry.key;
            final weekExpenses = entry.value;
            if (weekExpenses.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildParentTitle(week),
                if (_expanded[week] == true) _buildExpandedView(weekExpenses),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Padding _buildExpandedView(List<Expense> weekExpenses) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: weekExpenses
            .map(
              (expense) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white, // or slightly off-white
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildInnerTitle(expense),
              ),
            )
            .toList(),
      ),
    );
  }

  ListTile _buildInnerTitle(Expense expense) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: _buildTitleInnerTile(expense),
      subtitle: _buildSubTitleInnerTitle(expense),
      trailing: _buildTrailingAmount(expense),
    );
  }

  Text _buildTrailingAmount(Expense expense) {
    return Text(
      "- ₹${expense.amount.toStringAsFixed(2)}",

      style: appTextTheme.bodyLarge?.copyWith(
        color: Colors.redAccent,
        fontWeight: AppFontWeight.semiBold,
        fontSize: 12,
      ),
    );
  }

  Text _buildSubTitleInnerTitle(Expense expense) {
    return Text(
      expense.category,
      style: appTextTheme.bodyLarge?.copyWith(
        color: Colors.grey[600],
        fontWeight: AppFontWeight.regular,
        fontSize: 12,
      ),
    );
  }

  Text _buildTitleInnerTile(Expense expense) {
    return Text(
      expense.title,
      style: appTextTheme.bodyLarge?.copyWith(
        color: AppPallete.bgBlack,
        fontWeight: AppFontWeight.regular,
        fontSize: 14,
      ),
    );
  }

  ListTile _buildParentTitle(String week) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: _buildTitleOuterTile(week),
      trailing: _buildTrailingIcon(week),
      onTap: () {
        setState(() {
          _expanded[week] = !(_expanded[week] ?? false);
        });
      },
    );
  }

  Icon _buildTrailingIcon(String week) {
    return Icon(
      _expanded[week] == true ? Icons.expand_less : Icons.expand_more,
      color: Colors.grey[600],
    );
  }

  Text _buildTitleOuterTile(String week) {
    return Text(
      week,
      style: appTextTheme.bodyLarge?.copyWith(
        color: AppPallete.bgBlack,
        fontWeight: AppFontWeight.medium,
        fontSize: 16,
      ),
    );
  }
}
