import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repo/auth_repo/auth_repo_impl.dart' as _i598;
import '../../data/repo/main_repo/data_source/main_online_ds_impl.dart'
    as _i275;
import '../../data/repo/main_repo/main_repo_impl.dart' as _i929;
import '../../presentation/screens/auth/login/login_view_model.dart' as _i301;
import '../../presentation/screens/auth/register/register_view_model.dart'
    as _i801;
import '../../presentation/screens/main/tabs/home/home_tab_view_model.dart'
    as _i96;
import '../../presentation/shared_view_models/cart_view_model.dart' as _i857;
import '../../presentation/utils/shared_utils.dart' as _i775;
import '../repos/auth_repo/auth_repo.dart' as _i604;
import '../repos/main_repo/data_source/main_online_ds.dart' as _i141;
import '../repos/main_repo/main_repo.dart' as _i267;
import '../use_cases/add_to_cart_use_case.dart' as _i661;
import '../use_cases/get_all_categories_use_case.dart' as _i924;
import '../use_cases/get_all_products_use_case.dart' as _i564;
import '../use_cases/get_logged_user_cart_use_case.dart' as _i746;
import '../use_cases/login_use_case.dart' as _i119;
import '../use_cases/register_use_case.dart' as _i526;
import '../use_cases/remove_from_cart_use_case.dart' as _i474;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i895.Connectivity>(() => appModule.getConnectivity());
    gh.factory<_i775.SharedPrefsUtils>(() => _i775.SharedPrefsUtils());
    gh.factory<_i604.AuthRepo>(() => _i598.AuthRepoImpl(
          gh<_i895.Connectivity>(),
          gh<_i775.SharedPrefsUtils>(),
        ));
    gh.factory<_i119.LoginUseCase>(
        () => _i119.LoginUseCase(gh<_i604.AuthRepo>()));
    gh.factory<_i526.RegisterUseCase>(
        () => _i526.RegisterUseCase(gh<_i604.AuthRepo>()));
    gh.factory<_i141.MainOnlineDS>(
        () => _i275.MainOnlineDSImpl(gh<_i775.SharedPrefsUtils>()));
    gh.factory<_i801.RegisterViewModel>(
        () => _i801.RegisterViewModel(gh<_i526.RegisterUseCase>()));
    gh.factory<_i301.LoginViewModel>(
        () => _i301.LoginViewModel(gh<_i119.LoginUseCase>()));
    gh.factory<_i267.MainRepo>(() => _i929.MainRepoImpl(
          gh<_i895.Connectivity>(),
          gh<_i141.MainOnlineDS>(),
        ));
    gh.factory<_i661.AddToCartUseCase>(
        () => _i661.AddToCartUseCase(gh<_i267.MainRepo>()));
    gh.factory<_i924.GetAllCategoriesUseCase>(
        () => _i924.GetAllCategoriesUseCase(gh<_i267.MainRepo>()));
    gh.factory<_i564.GetAllProductsUseCase>(
        () => _i564.GetAllProductsUseCase(gh<_i267.MainRepo>()));
    gh.factory<_i746.GetLoggedUseCase>(
        () => _i746.GetLoggedUseCase(gh<_i267.MainRepo>()));
    gh.factory<_i474.RemoveFromCartUseCase>(
        () => _i474.RemoveFromCartUseCase(gh<_i267.MainRepo>()));
    gh.factory<_i857.CartViewModel>(() => _i857.CartViewModel(
          gh<_i746.GetLoggedUseCase>(),
          gh<_i661.AddToCartUseCase>(),
          gh<_i474.RemoveFromCartUseCase>(),
        ));
    gh.factory<_i96.HomeViewModel>(() => _i96.HomeViewModel(
          gh<_i924.GetAllCategoriesUseCase>(),
          gh<_i564.GetAllProductsUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
