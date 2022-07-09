import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/Product_small_details.dart';
import 'package:dash/widgets/app_icon.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:dash/widgets/icon_and_text_widget.dart';
import 'package:dash/widgets/small_text.dart';
import 'package:flutter/material.dart';

class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: Dimensions.popularFoodImageSize,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://foodtechclub.com/wp-content/uploads/2022/01/featured1.jpg'),
                    fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          top: Dimensions.height45,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppIcon(icon: Icons.arrow_back),
              AppIcon(icon: Icons.shopping_cart_outlined)
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: Dimensions.popularFoodImageSize - 20,
          child: Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
            ),
            child: const ProductSmallDetails(),
          ),
        ),
      ]),
    );
  }
}
