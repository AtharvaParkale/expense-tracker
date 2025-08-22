import 'dart:math';

import 'package:expense_tracker_app/core/common/widgets/card_widget.dart';
import 'package:expense_tracker_app/core/common/widgets/stat_title.dart';
import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
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
    spots.insert(0, const FlSpot(0, 0)); // dummy left
    spots.add(FlSpot(sortedKeys.length + 1, 0)); // dummy right

    final maxY = monthlyTotals.values.isEmpty
        ? 100.0
        : monthlyTotals.values.reduce(max).toDouble() * 1.2;

    return CardWidget(
      child: Column(
        children: [
          const StatTitle(title: "Monthly Breakdown"),
          const SizedBox(height: 10),
          _buildLineGraph(sortedKeys, maxY, monthlyTotals, spots, context),
        ],
      ),
    );
  }

  SizedBox _buildLineGraph(
    List<String> sortedKeys,
    double maxY,
    Map<String, double> monthlyTotals,
    List<FlSpot> spots,
    BuildContext context,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: max(400, sortedKeys.length * 90),

          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxY,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    reservedSize: 32, // ✅ extra space for labels
                    getTitlesWidget: (value, meta) {
                      final index =
                          value.toInt() - 1; // shift if dummy spot exists
                      if (index < 0 || index >= sortedKeys.length)
                        return const SizedBox.shrink();

                      final monthKey = sortedKeys[index];
                      final date = DateTime.parse("$monthKey-01");
                      return Padding(
                        padding: const EdgeInsets.only(top: 4), // extra padding
                        child: Text(
                          DateFormat('MMM').format(date),

                          style: appTextTheme.bodyMedium?.copyWith(
                            color: AppPallete.greyColor,
                            fontWeight: AppFontWeight.semiBold,
                            fontSize: 12,
                          ),
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
              lineTouchData: LineTouchData(
                handleBuiltInTouches: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  tooltipMargin: 8,
                  tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                  tooltipHorizontalOffset: 0,
                  maxContentWidth: 120,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  showOnTopOfTheChartBoxArea: true,
                  rotateAngle: 0.0,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final index = spot.x.toInt() - 1; // shift by -1 because of dummy start

                      if (index < 0 || index >= sortedKeys.length) {
                        // ✅ still return a placeholder to match length
                        return const LineTooltipItem(
                          "",
                          TextStyle(fontSize: 0), // invisible tooltip
                        );
                      }

                      final key = sortedKeys[index];
                      final value = monthlyTotals[key]!;

                      return LineTooltipItem(
                        "₹${value.toStringAsFixed(2)}",
                        const TextStyle(color: Colors.white, fontSize: 12),
                      );
                    }).toList(); // DO NOT filter with whereType, must match touchedSpots.length
                  },
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: AppPallete.primaryColor,
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
