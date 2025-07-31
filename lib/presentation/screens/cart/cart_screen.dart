import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/presentation/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';
import 'package:e_commerce_friday_c9/presentation/screens/cart/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = BlocProvider.of<CartViewModel>(context, listen: false);
    viewModel.getLoggedUserCart(); // ✅ جلب البيانات أول ما الشاشة تفتح
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartViewModel, dynamic>(
      builder: (context, state) {
        final items = viewModel.cartDM?.products ?? [];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: items.isEmpty
              ? const Center(
            child: Text("Your cart is empty.", style: TextStyle(fontSize: 18)),
          )
              : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final item = items[i];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.product?.imageCover ?? '',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.product?.title ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("EGP ${item.price}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () {
                              viewModel.removeProductFromCart(item.product!.id!);
                            },
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  viewModel.removeProductFromCart(item.product!.id!);
                                },
                              ),
                              Text("${item.count}", style: const TextStyle(fontSize: 16)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  viewModel.addProductToCart(item.product!.id!);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: items.isNotEmpty
              ? Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Price",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 4),
                      Text("EGP ${viewModel.cartDM?.totalCartPrice ?? 0}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CheckoutScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text("Check Out →",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          )
              : null,
        );
      },
    );
  }
}
