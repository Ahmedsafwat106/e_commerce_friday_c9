import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/categories_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/products_response.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/data_source/main_online_ds.dart';
import 'package:e_commerce_friday_c9/presentation/utils/constants.dart';
import 'package:e_commerce_friday_c9/presentation/utils/end_points.dart';
import 'package:e_commerce_friday_c9/presentation/utils/shared_utils.dart';

@Injectable(as: MainOnlineDS)
class MainOnlineDSImpl extends MainOnlineDS {
  SharedPrefsUtils utils;

  MainOnlineDSImpl(this.utils);

  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    try {
      Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.categories);
      Response serverResponse = await get(uri);
      CategoriesResponse response =
      CategoriesResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          response.data?.isNotEmpty == true) {
        return Right(response.data!);
      } else {
        return Left(Failure(response.message ?? Constants.defaultErrorMessage));
      }
    } catch (error, stacktrace) {
      print("Handling exception: ${error} , Stacktrace: $stacktrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    try {
      Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.products);
      Response serverResponse = await get(uri);
      ProductsResponse response =
      ProductsResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          response.data?.isNotEmpty == true) {
        return Right(response.data!);
      } else {
        return Left(Failure(response.message ?? Constants.defaultErrorMessage));
      }
    } catch (error, stacktrace) {
      print("Handling exception: ${error} , Stacktrace: $stacktrace");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> getLoggedUserCart() async {
    try {
      Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.addToCart);
      String token = (await utils.getToken())!;
      Response serverResponse = await get(uri, headers: {"token": token});
      CartResponse response =
      CartResponse.fromJson(jsonDecode(serverResponse.body));
      if (serverResponse.statusCode >= 200 &&
          serverResponse.statusCode < 300 &&
          response.data != null) {
        return Right(response.data!);
      } else {
        return Left(Failure(response.message ?? Constants.defaultErrorMessage));
      }
    } catch (e) {
      print("Exception while getLoggedUserCart : ${e} ");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> addProductToCart(String id) async {
    try {
      Uri uri = Uri.https(EndPoints.baseUrl, EndPoints.addToCart);
      String token = (await utils.getToken())!;
      Response serverResponse =
      await post(uri, body: {"productId": id}, headers: {"token": token});
      Map json = jsonDecode(serverResponse.body);
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        return getLoggedUserCart();
      } else {
        return Left(Failure(json["message"] ?? Constants.defaultErrorMessage));
      }
    } catch (e) {
      print("Exception while getLoggedUserCart : ${e} ");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeProductFromCart(String id) async {
    try {
      Uri uri =
      Uri.parse("https://${EndPoints.baseUrl}${EndPoints.addToCart}/$id");
      String token = (await utils.getToken())!;
      Response serverResponse = await delete(uri, headers: {"token": token});
      Map json = jsonDecode(serverResponse.body);
      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        return getLoggedUserCart();
      } else {
        return Left(Failure(json["message"] ?? Constants.defaultErrorMessage));
      }
    } catch (e) {
      print("Exception while getLoggedUserCart : ${e} ");
      return Left(Failure(Constants.defaultErrorMessage));
    }
  }
}