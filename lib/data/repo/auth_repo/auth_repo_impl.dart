import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/request/register_request_body.dart';
import 'package:e_commerce_friday_c9/data/model/response/auth_response.dart';
import 'package:e_commerce_friday_c9/domain/repos/auth_repo/auth_repo.dart';
import 'package:e_commerce_friday_c9/presentation/utils/constants.dart';
import 'package:e_commerce_friday_c9/presentation/utils/end_points.dart';
import 'package:e_commerce_friday_c9/presentation/utils/shared_utils.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  Connectivity connectivity;
  SharedPrefsUtils prefsUtils;

  AuthRepoImpl(this.connectivity, this.prefsUtils);

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    ConnectivityResult connectivityResult =
    await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.login);
        Response serverResponse =
        await post(uri, body: {"email": email, "password": password});
        AuthResponse response =
        AuthResponse.fromJson(jsonDecode(serverResponse.body));
        if (serverResponse.statusCode >= 200 &&
            serverResponse.statusCode < 300) {
          prefsUtils.saveUser(response.user!);
          prefsUtils.saveToken(response.token!);
          return const Right(true);
        } else {
          return Left(Failure(response.message ?? "something went wrong"));
        }
      } catch (_) {
        return Left(Failure(Constants.defaultErrorMessage));
      }
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> register(
      RegisterRequestBody requestBody) async {
    ConnectivityResult connectivityResult =
    await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.register);
      Response serverResponse = await post(uri, body: requestBody.toJson());
      AuthResponse response =
      AuthResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        prefsUtils.saveUser(response.user!);
        prefsUtils.saveToken(response.token!);
        return const Right(true);
      } else {
        return Left(Failure(response.message ?? Constants.defaultErrorMessage));
      }
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }
}