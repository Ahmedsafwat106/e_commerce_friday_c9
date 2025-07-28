
import 'package:e_commerce_friday_c9/data/model/response/cart_response.dart';

class CartDM {
  String? sId;
  String? cartOwner;
  List<CartProduct>? products;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? totalCartPrice;

  CartDM(
      {this.sId,
        this.cartOwner,
        this.products,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.totalCartPrice});

  CartDM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = <CartProduct>[];
      json['products'].forEach((v) {
        products!.add(new CartProduct.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }
}
