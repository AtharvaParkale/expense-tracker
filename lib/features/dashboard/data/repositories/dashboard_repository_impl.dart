import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/constants/error_codes.dart';
import 'package:expense_tracker_app/core/error/exceptions.dart';
import 'package:expense_tracker_app/core/error/failures.dart';
import 'package:expense_tracker_app/core/network/connection_checker.dart';
import 'package:expense_tracker_app/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:expense_tracker_app/features/dashboard/domain/entities/expense.dart';
import 'package:expense_tracker_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:fpdart/fpdart.dart' show Either, left, right;

class DashBoardRepositoryImpl implements DashboardRepository {
  final DashBoardRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const DashBoardRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, List<Expense>>> getExpensesByDateRange() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(
            Constants.noConnectionErrorMessage,
            ErrorCodes.noInternetConnectionErrorCode,
          ),
        );
      }

      final expenses = await remoteDataSource.getExpensesByDateRange();

      return right(expenses);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> addExpense({
    required String title,
    required String category,
    required double amount,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(
          Failure(
            Constants.noConnectionErrorMessage,
            ErrorCodes.noInternetConnectionErrorCode,
          ),
        );
      }

      final expenses = await remoteDataSource.addExpense(
        title: title,
        category: category,
        amount: amount,
      );

      return right(expenses);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
