import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Dimensions.width20 * 5,
        height: Dimensions.height20 * 5,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
          child:
              CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0),
        ),
      ),
    );
  }
}
