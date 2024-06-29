import 'package:flutter/material.dart';
import 'package:task_app/core/constants/app_colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text; // Updated to be non-nullable

  const MyButton({super.key, required this.onTap, required this.text}); // Corrected parameter usage

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text, // Corrected usage of the text parameter
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
