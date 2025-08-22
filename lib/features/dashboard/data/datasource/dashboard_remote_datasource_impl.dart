import 'package:expense_tracker_app/core/error/exceptions.dart';
import 'package:expense_tracker_app/core/utils/common_methods.dart';
import 'package:expense_tracker_app/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:expense_tracker_app/features/dashboard/data/models/expense_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardRemoteDatasourceImpl implements DashBoardRemoteDataSource {
  final SupabaseClient supabaseClient;

  DashboardRemoteDatasourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<List<ExpenseModel>> getAllExpenses(bool shouldFetchForDay) async {
    try {
      final expenses = await _getExpenses(shouldFetchForDay);
      return _convertExpensesToList(expenses);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ExpenseModel>> addExpense({
    required String title,
    required String category,
    required double amount,
  }) async {
    try {
      final expenses = await _addExpense(title, category, amount);

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

  Future<PostgrestList> _getExpenses(bool shouldFetchDailyExpenses) async {
    final todayRange = CommonMethods.getTodayRange();

    if(shouldFetchDailyExpenses){
      return await supabaseClient
          .from('expenses')
          .select('*')
          .gte('created_at', todayRange['start']!)
          .lte('created_at', todayRange['end']!)
          .eq('user_id', currentUserSession!.user.id);
    }
    else{
      return await supabaseClient
          .from('expenses')
          .select('*')
          .eq('user_id', currentUserSession!.user.id);
    }
  }

  Future _addExpense(String title, String category, double amount) async {
    await supabaseClient.from('expenses').insert({
      'title': title,
      'category': category,
      'amount': amount,
      'created_at': DateTime.now().toIso8601String(),
    });

    final expenses = await _getExpenses(true);

    return expenses;
  }
}
