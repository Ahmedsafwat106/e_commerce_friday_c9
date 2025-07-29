import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/presentation/screens/main/tabs/home/home_tab_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';
import 'package:e_commerce_friday_c9/presentation/utils/base_request_states.dart';
import 'package:e_commerce_friday_c9/presentation/utils/exentions.dart';
import 'package:e_commerce_friday_c9/presentation/widgets/category_item.dart';
import 'package:e_commerce_friday_c9/presentation/widgets/loading_widget.dart';
import 'package:e_commerce_friday_c9/presentation/widgets/product_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeViewModel viewModel = getIt();
  late CartViewModel cartViewModel;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cartViewModel = BlocProvider.of(context, listen: false);
    viewModel.loadCategories();
    viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            margin: const EdgeInsets.only(top: 12),
            child: TextField(
              controller: searchController,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    viewModel.loadProducts();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    viewModel.searchProducts(searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          CarouselSlider(
            items: [
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.icDiscount1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.icDiscount2),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.icDiscount3),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 20.h(context),
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              viewportFraction: 0.8,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: const Text(
              "Categories",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.primaryColor),
            ),
          ),
          SizedBox(
            height: 30.h(context),
            child: BlocBuilder(
              bloc: viewModel.getAllCategoriesUseCase,
              builder: (context, state) {
                if (state is BaseRequestSuccessState<List<CategoryDM>>) {
                  return buildCategoriesGridView(state.data!);
                } else if (state is BaseRequestErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: const Text(
              "Home Appliance",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: AppColors.primaryColor),
            ),
          ),
          SizedBox(
            height: 40.h(context),
            child: BlocBuilder(
              bloc: viewModel.getAllProductsUseCase,
              builder: (context, state) {
                if (state is BaseRequestSuccessState<List<ProductDM>>) {
                  return buildProductsListView(state.data!);
                } else if (state is BaseRequestErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductsListView(List<ProductDM> data) {
    return BlocBuilder<CartViewModel, dynamic>(
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            var product = data[index];
            return ProductItem(
              productDM: product,
              isInCart: cartViewModel.isInCart(product) != null,
            );
          },
        );
      },
    );
  }

  Widget buildCategoriesGridView(List<CategoryDM> data) {
    return GridView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return CategoryItem(data[index]);
      },
    );
  }
}
