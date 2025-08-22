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

    // Get unique months from expenses
    final monthsSet = widget.expenses
        .map((e) => DateFormat('yyyy-MM').format(DateTime.parse(e.createdAt)))
        .toSet();

    availableMonths = monthsSet.toList()..sort();

    // Default selection
    selectedMonthKey = availableMonths.isNotEmpty ? availableMonths.first : "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (availableMonths.isNotEmpty)
          DropdownButton<String>(
            value: selectedMonthKey,
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
    );
  }
}
