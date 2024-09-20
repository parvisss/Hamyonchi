import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: AppColors.primaryGradient),
      child: const Icon(
        Icons.add,
        color: AppColors.colorWhite,
        size: 30,
      ),
    );
  }
}
