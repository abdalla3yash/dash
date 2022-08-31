
import 'package:dash/utils/colors.dart';
import 'package:dash/widgets/small_text.dart';
import "package:flutter/material.dart";

import '../utils/dimensions.dart';
import 'bit_text.dart';
import 'icon_and_text_widget.dart';

class ProductSmallDetails extends StatelessWidget {
  final String text;
  const ProductSmallDetails({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        text: text,
        size: Dimensions.font26,
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      Row(
        children: [
          Wrap(
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SmallText(
            text: "4.5",
          ),
          const SizedBox(
            width: 10,
          ),
          SmallText(
            text: "1284",
          ),
          const SizedBox(
            width: 4,
          ),
          SmallText(
            text: "Comments",
          ),
        ],
      ),
      SizedBox(
        height: Dimensions.height20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndWidgetText(
              text: "Normal",
              icon: Icons.circle_sharp,
              iconColor: AppColors.iconColor1),
          IconAndWidgetText(
              text: "1.7km",
              icon: Icons.location_on,
              iconColor: AppColors.mainColor),
          IconAndWidgetText(
              text: "30min",
              icon: Icons.access_time_rounded,
              iconColor: AppColors.iconColor2),
        ],
      ),
    ]);
  }
}
