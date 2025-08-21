import 'package:expense_tracker_app/features/dashboard/data/models/expense_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DashBoardRemoteDataSource {
  Session? get currentUserSession;

  Future<List<ExpenseModel>> getExpensesByDateRange();
}
