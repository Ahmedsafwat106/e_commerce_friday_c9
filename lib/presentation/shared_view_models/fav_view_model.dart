import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';

class FavViewModel extends Cubit<List<ProductDM>> {
  FavViewModel() : super([]);

  void toggleFavorite(ProductDM product) {
    final current = List<ProductDM>.from(state);
    final index = current.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      current.removeAt(index);
    } else {
      current.add(product);
    }
    emit(current);
  }

  bool isFavorite(ProductDM product) {
    return state.any((p) => p.id == product.id);
  }
}
