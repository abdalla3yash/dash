import 'package:dash/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  Color? color;
  final String? text;
  double size, height;

  SmallText({
    super.key,
    this.color = AppColors.textColor,
    this.text,
    this.size = 12,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(color: color, height: height, fontSize: size),
    );
  }
}
