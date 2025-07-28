
import 'package:dartz/dartz.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/request/register_request_body.dart';

abstract class AuthRepo {
  Future<Either<Failure, bool>> login(String email, String password);

  Future<Either<Failure, bool>> register(RegisterRequestBody requestBody);
}
