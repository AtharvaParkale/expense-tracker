import 'package:expense_tracker_app/core/error/exceptions.dart';
import 'package:expense_tracker_app/features/dashboard/data/models/expense_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class DashboardLocalDataSource {
  Future<List<ExpenseModel>> getAllExpenses();

  Future<void> saveExpenses(List<ExpenseModel> expenses);
}

class DashboardLocalDatasourceImpl implements DashboardLocalDataSource {
  static const _boxName = 'expenses';
    Box<ExpenseModel>? expenseBox;


  Future<void> _init() async {
    if (expenseBox != null && expenseBox!.isOpen) return;

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExpenseModelAdapter());
    }

    expenseBox = await Hive.openBox<ExpenseModel>(_boxName);
  }

  @override
  Future<List<ExpenseModel>> getAllExpenses() async {
    try {

      await _init();
      final expenses = expenseBox?.values.toList();

      return expenses??[];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveExpenses(List<ExpenseModel> expenses) async {
    await _init();
    for (var exp in expenses) {
      await expenseBox?.put(exp.id, exp);
    }
  }
}
