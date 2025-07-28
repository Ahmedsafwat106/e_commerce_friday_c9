import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/cart_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/add_to_cart_use_case.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/get_logged_user_cart_use_case.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:e_commerce_friday_c9/presentation/utils/base_request_states.dart';

@injectable
class CartViewModel extends Cubit {
  GetLoggedUseCase getLoggedUseCase;
  AddToCartUseCase addToCartUseCase;
  RemoveFromCartUseCase removeFromCartUseCase;
  CartDM? cartDM;

  CartViewModel(
      this.getLoggedUseCase, this.addToCartUseCase, this.removeFromCartUseCase)
      : super(BaseRequestInitialState());

  void addProductToCart(String id) async {
    Either<Failure, CartDM> either = await addToCartUseCase.execute(id);
    either.fold((failure) {
      emit(BaseRequestErrorState(failure.errorMessage));
    }, (cart) {
      cartDM = cart;
      emit(BaseRequestSuccessState());
    });
  }

  void removeProductFromCart(String id) async {
    Either<Failure, CartDM> either = await removeFromCartUseCase.execute(id);
    either.fold((failure) {
      emit(BaseRequestErrorState(failure.errorMessage));
    }, (cart) {
      cartDM = cart;
      emit(BaseRequestSuccessState());
    });
  }

  void getLoggedUserCart() async {
    Either<Failure, CartDM> either = await getLoggedUseCase.execute();
    either.fold((failure) {
      emit(BaseRequestErrorState(failure.errorMessage));
    }, (cart) {
      cartDM = cart;
      emit(BaseRequestSuccessState());
    });
  }

  CartProduct? isInCart(ProductDM productDM) {
    if (cartDM != null && cartDM!.products != null) {
      var productInCart = cartDM!.products!;
      for (int i = 0; i < productInCart.length; i++) {
        if (productDM.id == productInCart[i].product?.id) {
          return productInCart[i];
        }
      }
    }
    return null;
  }
}