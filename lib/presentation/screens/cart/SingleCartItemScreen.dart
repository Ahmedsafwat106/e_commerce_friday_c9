import 'package:flutter/material.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';

class SingleCartItemScreen extends StatelessWidget {
  static const String routeName = "single-cart-item";

  final ProductDM product;

  const SingleCartItemScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.imageCover ?? '',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title ?? "",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(
                        "Orange | Size: 40",
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Text("EGP ${product.price}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove, color: Colors.white)),
                      const Text("1",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add, color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total price",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.primaryColor)),
                    const SizedBox(height: 6),
                    Text("EGP ${product.price}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Row(
                    children: [
                      Text("Check Out",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
