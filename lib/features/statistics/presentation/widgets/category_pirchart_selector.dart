import 'package:expense_tracker_app/core/common/widgets/card_widget.dart';
import 'package:expense_tracker_app/core/common/widgets/stat_title.dart';
import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'category_pie_chart.dart';

class CategoryPieChartSelector extends StatefulWidget {
  final List<Expense> expenses;

  const CategoryPieChartSelector({super.key, required this.expenses});

  @override
  State<CategoryPieChartSelector> createState() =>
      _CategoryPieChartSelectorState();
}

class _CategoryPieChartSelectorState extends State<CategoryPieChartSelector> {
  late List<String> availableMonths;
  String selectedMonthKey = "";

  @override
  void initState() {
    super.initState();

    final monthsSet = widget.expenses
        .map((e) => DateFormat('yyyy-MM').format(DateTime.parse(e.createdAt)))
        .toSet();

    availableMonths = monthsSet.toList()..sort();

    selectedMonthKey = availableMonths.isNotEmpty ? availableMonths.first : "";
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatTitle(title: "Category Breakdown"),
          const SizedBox(height: 15),
          if (availableMonths.isNotEmpty)
            DropdownButton<String>(
              value: selectedMonthKey,
              style: appTextTheme.bodyMedium?.copyWith(
                color: AppPallete.greyColor,
                fontWeight: AppFontWeight.semiBold,
                fontSize: 14,
              ),
              items: availableMonths.map((monthKey) {
                final date = DateFormat('yyyy-MM').parse(monthKey);
                final label = DateFormat('MMMM yyyy').format(date);
                return DropdownMenuItem(value: monthKey, child: Text(label));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedMonthKey = val;
                  });
                }
              },
            ),
          const SizedBox(height: 10),
          if (selectedMonthKey.isNotEmpty)
            CategoryPieChart(
              expenses: widget.expenses,
              monthKey: selectedMonthKey,
            ),
        ],
      ),
    );
  }
}
