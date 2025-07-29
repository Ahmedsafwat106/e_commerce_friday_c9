import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:e_commerce_friday_c9/presentation/widgets/category_item.dart';
import 'package:e_commerce_friday_c9/presentation/utils/base_request_states.dart';
import 'package:e_commerce_friday_c9/presentation/widgets/loading_widget.dart';
import 'package:e_commerce_friday_c9/presentation/screens/main/tabs/home/home_tab_view_model.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<HomeViewModel>();
    viewModel.loadCategories();

    return BlocBuilder(
      bloc: viewModel.getAllCategoriesUseCase,
      builder: (context, state) {
        if (state is BaseRequestLoadingState) {
          return const LoadingWidget();
        } else if (state is BaseRequestErrorState) {
          return Center(child: Text(state.message));
        } else if (state is BaseRequestSuccessState<List<CategoryDM>>) {
          final data = state.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: data.length,
            itemBuilder: (_, index) => CategoryItem(data[index]),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
