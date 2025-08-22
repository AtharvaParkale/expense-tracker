import 'dart:math';

import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlySpendsChart extends StatelessWidget {
  final List<Expense> expenses;

  const MonthlySpendsChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final Map<String, double> monthlyTotals = {};

    for (final expense in expenses) {
      final date = DateTime.parse(expense.createdAt);

      // ✅ Filter only current year expenses
      if (date.year == currentYear) {
        final key = DateFormat('yyyy-MM').format(date); // e.g., "2025-08"
        monthlyTotals[key] = (monthlyTotals[key] ?? 0) + expense.amount;
      }
    }

    final sortedKeys = monthlyTotals.keys.toList()..sort();

    // Create spots with dummy padding at start and end
    final spots = <FlSpot>[];
    for (int i = 0; i < sortedKeys.length; i++) {
      spots.add(FlSpot(i.toDouble() + 1, monthlyTotals[sortedKeys[i]]!));
    }

    // Add left and right padding
    spots.insert(0, FlSpot(0, 0)); // dummy left
    spots.add(FlSpot(sortedKeys.length + 1, 0)); // dummy right

    final maxY = monthlyTotals.values.isEmpty
        ? 100.0
        : monthlyTotals.values.reduce(max).toDouble() * 1.2;

    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: max(400, sortedKeys.length * 90), // dynamic scrollable width
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxY,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index <= 0 || index > sortedKeys.length) {
                        return const SizedBox.shrink(); // hide dummy spots
                      }
                      final monthKey = sortedKeys[index - 1]; // shift index
                      final date = DateTime.parse("$monthKey-01");
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          DateFormat('MMM').format(date),
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
