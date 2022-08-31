import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool obsecure;

  const AppTextField(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.icon,
      this.obsecure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(2, 3),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        obscureText: obsecure,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
      ),
    );
  }
}
