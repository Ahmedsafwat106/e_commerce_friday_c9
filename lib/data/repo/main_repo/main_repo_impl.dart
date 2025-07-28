import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/data_source/main_online_ds.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/main_repo.dart';
import 'package:e_commerce_friday_c9/presentation/utils/constants.dart';
import 'package:e_commerce_friday_c9/presentation/utils/exentions.dart';

@Injectable(as: MainRepo)
class MainRepoImpl extends MainRepo {
  Connectivity connectivity;
  MainOnlineDS mainOnlineDs;

  MainRepoImpl(this.connectivity, this.mainOnlineDs);

  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    if (await connectivity.isInternetConnected) {
      return mainOnlineDs.getCategories();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    if (await connectivity.isInternetConnected) {
      return mainOnlineDs.getProducts();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> addProductToCart(String id) async {
    if (await connectivity.isInternetConnected) {
      return mainOnlineDs.addProductToCart(id);
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> getLoggedUserCart() async {
    if (await connectivity.isInternetConnected) {
      return mainOnlineDs.getLoggedUserCart();
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeProductFromCart(String id) async {
    if (await connectivity.isInternetConnected) {
      return mainOnlineDs.removeProductFromCart(id);
    } else {
      return Left(Failure(Constants.internetErrorMessage));
    }
  }
}