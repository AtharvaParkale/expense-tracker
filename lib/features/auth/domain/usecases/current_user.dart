import 'package:expense_tracker_app/core/error/failures.dart';
import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await authRepository.isUserLoggedIn();
  }
}
