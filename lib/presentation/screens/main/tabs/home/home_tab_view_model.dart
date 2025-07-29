import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/get_all_categories_use_case.dart';
import 'package:e_commerce_friday_c9/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce_friday_c9/presentation/utils/base_request_states.dart';

@injectable
class HomeViewModel extends Cubit {
  GetAllCategoriesUseCase getAllCategoriesUseCase;
  GetAllProductsUseCase getAllProductsUseCase;

  HomeViewModel(this.getAllCategoriesUseCase, this.getAllProductsUseCase)
      : super(BaseRequestInitialState());

  void loadCategories() {
    getAllCategoriesUseCase.execute();
  }

  void loadProducts() {
    getAllProductsUseCase.execute();
  }

  void searchProducts(String query) {
    getAllProductsUseCase.execute(params: query);
  }
}
