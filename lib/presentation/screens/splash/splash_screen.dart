import 'package:flutter/material.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_assets.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';

import '../../../data/model/response/auth_response.dart';
import '../../utils/shared_utils.dart';
import '../auth/login/login.dart';
import '../main/main.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      User? user = await SharedPrefsUtils().getUser();
      if (user == null) {
        Navigator.pushReplacementNamed(context, Login.routeName);
      } else {
        Navigator.pushReplacementNamed(context, Main.routeName);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    mq.width * (1 - _animation.value),
                    // Slide from right to left
                    0,
                  ),
                  child: child,
                );
              },
              child: Container(
                color: AppColors.primaryColor,
                child: Center(
                  child: Image.asset(
                    AppAssets.splash,
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.width * .50,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: mq.height * .10,
              left: mq.width * .05,
              width: mq.width * .9,
              height: mq.height * .18,
              child: Container(
                margin: const EdgeInsets.all(12),
                child: const Text(
                  "Welcome To e_commerce_friday_c9 Application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}