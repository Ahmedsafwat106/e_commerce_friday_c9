import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_friday_c9/domain/repos/main_repo/main_repo.dart';
import 'package:e_commerce_friday_c9/data/model/failure.dart';
import 'package:e_commerce_friday_c9/data/model/response/product_dm.dart';
import 'package:e_commerce_friday_c9/presentation/utils/base_request_states.dart';

@injectable
class GetAllProductsUseCase extends Cubit<BaseRequestStates> {
  final MainRepo repo;

  GetAllProductsUseCase(this.repo) : super(BaseRequestInitialState());

  Future<void> execute({String? params}) async {
    emit(BaseRequestLoadingState());
    final either = await repo.getProducts(); // بدون بحث
    either.fold(
          (failure) => emit(BaseRequestErrorState(failure.errorMessage)),
          (products) {
        // لو في بحث:
        if (params != null && params.trim().isNotEmpty) {
          final filtered = products
              .where((p) => p.title
              ?.toLowerCase()
              .contains(params.toLowerCase()) ??
              false)
              .toList();
          emit(BaseRequestSuccessState<List<ProductDM>>(data: filtered));
        } else {
          emit(BaseRequestSuccessState<List<ProductDM>>(data: products));
        }
      },
    );
  }
}
