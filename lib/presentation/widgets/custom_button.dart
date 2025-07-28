import 'package:flutter/material.dart';
import 'package:e_commerce_friday_c9/presentation/utils/app_color.dart';

class CustomButtonWidget extends StatelessWidget {
  String title;
  Function()? onPressed;

  CustomButtonWidget({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPressed,
      child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}