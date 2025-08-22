import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryPieChart extends StatelessWidget {
  final List<Expense> expenses;
  final String monthKey;

  const CategoryPieChart({
    super.key,
    required this.expenses,
    required this.monthKey,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Food',
      'Transport',
      'Shopping',
      'Bills',
      'Entertainment',
      'Health',
      'Other',
    ];

    final Map<String, Color> categoryColors = {
      'Food': const Color(0xFF90CAF9),
      'Transport': const Color(0xFFA5D6A7),
      'Shopping': const Color(0xFFFFCC80),
      'Bills': const Color(0xFFEF9A9A),
      'Entertainment': const Color(0xFFCE93D8),
      'Health': const Color(0xFF80CBC4),
      'Other': const Color(0xFFD7CCC8),
    };

    final Map<String, double> categoryTotals = {
      for (var c in categories) c: 0.0,
    };

    for (final expense in expenses) {
      final date = DateTime.parse(expense.createdAt);
      final key = DateFormat('yyyy-MM').format(date);
      if (key == monthKey) {
        categoryTotals[expense.category] =
            (categoryTotals[expense.category] ?? 0) + expense.amount;
      }
    }

    final total = categoryTotals.values.fold(0.0, (a, b) => a + b);

    final pieSections = <PieChartSectionData>[];
    categoryTotals.forEach((category, value) {
      if (value > 0) {
        pieSections.add(
          PieChartSectionData(
            value: value,
            color: categoryColors[category],
            title: "${(value / total * 100).toStringAsFixed(1)}%",
            radius: 60,
            titleStyle: appTextTheme.bodyMedium?.copyWith(
              color: AppPallete.whiteColor,
              fontWeight: AppFontWeight.semiBold,
              fontSize: 12,
            ),
          ),
        );
      }
    });

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(
              sections: pieSections,
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: categories.map((category) {
            final value = categoryTotals[category] ?? 0;
            if (value == 0) return const SizedBox.shrink();
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 14,
                  height: 14,
                  color: categoryColors[category],
                ),
                const SizedBox(width: 6),
                Text(
                  "$category (₹${value.toStringAsFixed(0)})",
                  style: appTextTheme.bodyMedium?.copyWith(
                    color: AppPallete.greyColor,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 11,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
