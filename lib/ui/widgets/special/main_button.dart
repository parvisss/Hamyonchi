import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.title, required this.function});
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            gradient: AppColors.primaryGradient,
            boxShadow: const [
              BoxShadow(
                color: AppColors.primaryColor2,
                blurRadius: 5,
                offset: Offset(
                  2,
                  2,
                ),
              )
            ]),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: AppColors.colorWhite, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
