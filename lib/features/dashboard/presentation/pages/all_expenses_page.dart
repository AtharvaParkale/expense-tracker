import 'package:expense_tracker_app/core/constants/app_font_weigth.dart';
import 'package:expense_tracker_app/core/theme/app_pallete.dart';
import 'package:expense_tracker_app/core/theme/app_text_theme.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/presentation/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';

class AllExpensesPage extends StatefulWidget {
  static route(expenses) => MaterialPageRoute(
    builder: (context) => AllExpensesPage(expenses: expenses),
  );
  final List<Expense>? expenses;

  const AllExpensesPage({super.key, required this.expenses});

  @override
  State<AllExpensesPage> createState() => _AllExpensesPageState();
}

class _AllExpensesPageState extends State<AllExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "All Expenses",
          style: appTextTheme.bodyLarge?.copyWith(
            color: AppPallete.bgBlack,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        backgroundColor: AppPallete.whiteColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
        child: TransactionListWidget(expenses: widget.expenses),
      ),
    );
  }
}
