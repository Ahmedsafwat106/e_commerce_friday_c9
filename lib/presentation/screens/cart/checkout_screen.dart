import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/presentation/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = "checkout";

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = BlocProvider.of<CartViewModel>(context);
    final cartItems = cartViewModel.cartDM?.products ?? [];
    final totalPrice = cartItems.fold(0.0, (sum, item) => sum + (item.price ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(item.product?.imageCover ?? '', width: 50, height: 50),
                    title: Text(item.product?.title ?? ''),
                    subtitle: Text("Qty: ${item.count}"),
                    trailing: Text("EGP ${item.price}"),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("EGP ${totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                cartViewModel.placeOrder();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully!")),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Center(
                child: Text("Confirm Order", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
