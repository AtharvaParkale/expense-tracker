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
    return SizedBox(
      height: widget.height, // respects your height
      child: ListView(
        children: widget.groupedExpenses.entries.map((entry) {
          final week = entry.key;
          final weekExpenses = entry.value;

          if (weekExpenses.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  week,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  _expanded[week] == true ? Icons.expand_less : Icons.expand_more,
                ),
                onTap: () {
                  setState(() {
                    _expanded[week] = !(_expanded[week] ?? false);
                  });
                },
              ),
              if (_expanded[week] == true)
                ...weekExpenses.map(
                      (expense) => ListTile(
                    title: Text(expense.title),
                    subtitle: Text(expense.category),
                    trailing: Text("₹${expense.amount.toStringAsFixed(2)}"),
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
