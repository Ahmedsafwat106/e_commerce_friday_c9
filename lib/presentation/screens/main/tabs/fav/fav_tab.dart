import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/presentation/screens/product_datails/product_datails_screen.dart';
import 'package:e_commerce_friday_c9/presentation/shared_view_models/fav_view_model.dart';

class FAVTab extends StatelessWidget {
  const FAVTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavViewModel, List<ProductDM>>(
      builder: (context, favorites) {
        if (favorites.isEmpty) {
          return const Center(child: Text("No favorites yet"));
        }
        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (_, index) {
            final product = favorites[index];
            return ListTile(
              leading: Image.network(product.imageCover ?? ''),
              title: Text(product.title ?? ''),
              subtitle: Text("EGP ${product.price}"),
              onTap: () {
                Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                    arguments: product);
              },
            );
          },
        );
      },
    );
  }
}
