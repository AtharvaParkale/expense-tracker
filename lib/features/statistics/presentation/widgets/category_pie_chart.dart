import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryPieChart extends StatelessWidget {
  final List<Expense> expenses;
  final String monthKey; // e.g., "2025-08"

  const CategoryPieChart({
    super.key,
    required this.expenses,
    required this.monthKey,
  });

  @override
  Widget build(BuildContext context) {
    // Fixed categories list
    final categories = [
      'Food',
      'Transport',
      'Shopping',
      'Bills',
      'Entertainment',
      'Health',
      'Other',
    ];

    // Fixed colors (same order as categories)
    final categoryColors = {
      'Food': Colors.blue,
      'Transport': Colors.green,
      'Shopping': Colors.orange,
      'Bills': Colors.red,
      'Entertainment': Colors.purple,
      'Health': Colors.teal,
      'Other': Colors.brown,
    };

    // Aggregate totals for the given month
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
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
        // Legend with category + spend amount
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
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
