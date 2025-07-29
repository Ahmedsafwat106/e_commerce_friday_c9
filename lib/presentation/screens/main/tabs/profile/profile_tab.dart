import 'package:flutter/material.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';
import 'package:e_commerce_friday_c9/presentation/screens/auth/login/login.dart';
import 'package:e_commerce_friday_c9/presentation/utils/shared_utils.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  void logout(BuildContext context) async {
    await SharedPrefsUtils().saveUser(null);
    await SharedPrefsUtils().saveToken('');
    Navigator.pushReplacementNamed(context, Login.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => logout(context),
        icon: const Icon(Icons.logout),
        label: const Text("Logout"),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
