import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/presentation/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = "cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = BlocProvider.of<CartViewModel>(context);
    final cartItems = cartViewModel.cartDM?.products ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          "Your cart is empty.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            leading: Image.network(
              item.product?.imageCover ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item.product?.title ?? ''),
            subtitle: Text(
                "Quantity: ${item.count} | Price: EGP ${item.price}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                cartViewModel.removeProductFromCart(item.product!.id!);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // TODO: تنفيذ الشراء
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor),
          child: const Text(
            "Proceed to Checkout",
            style: TextStyle(fontSize: 18),
          ),
        ),
      )
          : null,
    );
  }
}
