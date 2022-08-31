// ignore_for_file: must_be_immutable

import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/app_icon.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height10,
          right: Dimensions.width20,
          bottom: Dimensions.height10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2))
      ]),
      child: Row(
          children: [appIcon, SizedBox(width: Dimensions.width15), bigText]),
    );
  }
}
