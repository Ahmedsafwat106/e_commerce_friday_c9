import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';

@injectable
class LoginUseCase {
  AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  Future<Either<Failure, bool>> execute(String email, String password) {
    return authRepo.login(email, password);
  }
}