import 'package:e_commerce_friday_c9/presentation/screens/cart/SingleCartItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_friday_c9/domain/di/di.dart';
import 'package:e_commerce_friday_c9/presentation/screens/auth/login/login.dart';
import 'package:e_commerce_friday_c9/presentation/screens/auth/register/register.dart';
import 'package:e_commerce_friday_c9/presentation/screens/main/main.dart';
import 'package:e_commerce_friday_c9/presentation/screens/product_datails/product_datails_screen.dart';
import 'package:e_commerce_friday_c9/presentation/screens/splash/splash_screen.dart';
import 'package:e_commerce_friday_c9/presentation/shared_view_models/cart_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/shared_view_models/fav_view_model.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_theme.dart';
import 'package:e_commerce_friday_c9/presentation/screens/cart/checkout_screen.dart';
import 'package:e_commerce_friday_c9/presentation/screens/cart/cart_screen.dart';
import 'data/model/response/product_dm.dart';

void main() {
  configureDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<CartViewModel>()),
      BlocProvider(create: (_) => FavViewModel()),
    ],
    child: const TaswakApp(),
  ));
}

class TaswakApp extends StatelessWidget {
  const TaswakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        Login.routeName: (_) => Login(),
        Register.routeName: (_) => Register(),
        Main.routeName: (_) => Main(),
        ProductDetailsScreen.routeName: (_) => ProductDetailsScreen(),
        CartScreen.routeName: (_) => CartScreen(),
        CheckoutScreen.routeName: (_) => CheckoutScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == SingleCartItemScreen.routeName) {
          final product = settings.arguments as ProductDM;
          return MaterialPageRoute(
            builder: (_) => SingleCartItemScreen(product: product),
          );
        }
        return null;
      },
    );
  }
}
