import 'package:e_commerce_friday_c9/data/model/base_response.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';

import 'cart_dm.dart';

class CartResponse extends BaseResponseM {
  String? status;
  int? numOfCartItems;
  CartDM? data;

  CartResponse({this.status, this.numOfCartItems, this.data});

  CartResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['status'];
    numOfCartItems = json['numOfCartItems'];
    data = json['data'] != null ? new CartDM.fromJson(json['data']) : null;
  }
}

class CartProduct {
  int? count;
  String? sId;
  ProductDM? product;
  int? price;

  CartProduct({this.count, this.sId, this.product, this.price});

  CartProduct.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sId = json['_id'];
    product = json['product'] != null
        ? new ProductDM.fromJson(json['product'])
        : null;
    price = json['price'];
  }
}
