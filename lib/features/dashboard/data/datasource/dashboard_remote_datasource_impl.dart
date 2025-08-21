import 'package:expense_tracker_app/core/error/exceptions.dart';
import 'package:expense_tracker_app/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:expense_tracker_app/features/dashboard/data/models/expense_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardRemoteDatasourceImpl implements DashBoardRemoteDataSource {
  final SupabaseClient supabaseClient;

  DashboardRemoteDatasourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<List<ExpenseModel>> getExpensesByDateRange() async {
    try {
      final expenses = await _getDailyExpenses();
      return _convertExpensesToList(expenses);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  List<ExpenseModel> _convertExpensesToList(PostgrestList expenses) {
    return expenses.map((expense) => ExpenseModel.fromJson(expense)).toList();
  }

  Future<PostgrestList> _getDailyExpenses() async {
    return await supabaseClient
        .from('expenses')
        .select('*')
        .gte('created_at', '2025-08-21T00:00:00Z')
        .lte('created_at', '2025-08-21T23:59:59Z')
        .eq('user_id', currentUserSession!.user.id);
  }
}
