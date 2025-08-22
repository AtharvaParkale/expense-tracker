import 'package:expense_tracker_app/core/common/entities/user.dart';
import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/constants/error_codes.dart';
import 'package:expense_tracker_app/core/error/exceptions.dart';
import 'package:expense_tracker_app/core/error/failures.dart';
import 'package:expense_tracker_app/core/network/connection_checker.dart';
import 'package:expense_tracker_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, bool>> isUserLoggedIn() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(true);
      }
      final isUserLoggedIn = await remoteDataSource.isUserLoggedIn();

      if (!isUserLoggedIn) return left(Failure('User not logged in!'));

      return right(isUserLoggedIn);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure(
            Constants.noConnectionErrorMessage,
            ErrorCodes.noInternetConnectionErrorCode,
          ),
        );
      }
      final user = await fn();

      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message, e.code));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
