import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/usecases/get_all_expenses.dart';
import 'package:meta/meta.dart';

part 'statistics_event.dart';

part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final GetAllExpenses _getAllExpenses;

  StatisticsBloc({required GetAllExpenses getAllExpenses})
    : _getAllExpenses = getAllExpenses,
      super(StatisticsInitial()) {
    on<GetAllTheExpensesEvent>(_onGetAllTheExpensesEvent);
  }

  Future<void> _onGetAllTheExpensesEvent(
    GetAllTheExpensesEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    final res = await _getAllExpenses(false);
    res.fold(
      (l) => emit(ErrorState(message: l.message)),
      (r) => _handleExpensesDataState(emit, r),
    );
  }

  void _handleExpensesDataState(
    Emitter<StatisticsState> emit,
    List<Expense> r,
  ) {
    if (r.isEmpty) {
      emit(NoExpensesFoundState());
    } else {
      emit(AllExpensesSuccessState(expenses: r));
    }
  }
}
