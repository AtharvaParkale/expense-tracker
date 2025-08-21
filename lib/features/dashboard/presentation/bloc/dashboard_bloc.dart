import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/usecases/get_expenses_by_date_range.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetExpensesByDateRange _getExpensesByDateRange;

  DashboardBloc({required GetExpensesByDateRange getExpensesByDateRange})
    : _getExpensesByDateRange = getExpensesByDateRange,
      super(DashboardInitial()) {
    on<GetExpensesByDateRangeEvent>(_onGetAllExpensesByDateRange);
  }

  Future<void> _onGetAllExpensesByDateRange(
    GetExpensesByDateRangeEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(LoadingState());
    final res = await _getExpensesByDateRange(NoParams());
    res.fold(
      (l) => emit(ErrorState(message: l.message)),
      (r) => _handleExpensesDataState(emit, r),
    );
  }

  void _handleExpensesDataState(Emitter<DashboardState> emit, List<Expense> r) {
    if (r.isEmpty) {
      emit(NoDailyExpensesFoundState());
    } else {
      emit(DailyExpensesSuccessState(expenses: r));
    }
  }
}
