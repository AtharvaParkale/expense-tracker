import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/core/utils/common_methods.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/daily_expense_summary.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/usecases/add_expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/usecases/get_all_expenses.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAllExpenses _getExpensesByDateRange;
  final AddExpense _addExpense;

  DashboardBloc({
    required GetAllExpenses getExpensesByDateRange,
    required AddExpense addExpense,
  }) : _getExpensesByDateRange = getExpensesByDateRange,
       _addExpense = addExpense,
       super(DashboardInitial()) {
    on<GetExpensesByDateRangeEvent>(_onGetAllExpensesByDateRange);
    on<AddExpenseEvent>(_onAddExpenseEvent);
  }

  Future<void> _onGetAllExpensesByDateRange(
    GetExpensesByDateRangeEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(LoadingState());
    final res = await _getExpensesByDateRange(true);
    res.fold(
      (l) => emit(ErrorState(message: l.message)),
      (r) => _handleExpensesDataState(emit, r),
    );
  }

  Future<void> _onAddExpenseEvent(
    AddExpenseEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(LoadingState());
    final res = await _addExpense(
      AddExpenseParams(
        title: event.title,
        category: event.category,
        amount: event.amount,
      ),
    );
    res.fold(
      (l) => emit(ErrorState(message: l.message)),
      (r) => _handleExpensesDataState(emit, r),
    );
  }

  void _handleExpensesDataState(Emitter<DashboardState> emit, List<Expense> r) {
    if (r.isEmpty) {
      emit(
        NoDailyExpensesFoundState(
          dailyExpenseSummary: DailyExpenseSummary(
            r,
            total: 0.0,
            totalCount: 0,
            average: 0,
            max: 0,
          ),
        ),
      );
    } else {
      emit(
        DailyExpensesSuccessState(
          dailyExpenseSummary: DailyExpenseSummary(
            r,
            total: CommonMethods.getTotal(r),
            totalCount: CommonMethods.getCount(r),
            average: CommonMethods.getAverage(r),
            max: CommonMethods.getMaxExpenseAmount(r),
          ),
        ),
      );
    }
  }
}
