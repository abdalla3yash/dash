import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/Product_small_details.dart';
import 'package:dash/widgets/app_icon.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:dash/widgets/exandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PopularFoodDetails extends StatelessWidget {
  int pageId;
  final String page;
  PopularFoodDetails({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: Dimensions.popularFoodImageSize,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        '${AppConstant.LAUNCH}/uploads/${product.img!}'),
                    fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          top: Dimensions.height45,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.offAllNamed(RouteHelper.getInitial());
                  },
                  child: const AppIcon(icon: Icons.close)),
              GetBuilder<PopularProductController>(builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: Stack(
                    children: [
                      const AppIcon(icon: Icons.shopping_cart_outlined),
                      controller.totalItems >= 1
                          ? const Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 5,
                              top: 5,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ))
                          : Container(),
                    ],
                  ),
                );
              }),
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20),
                topRight: Radius.circular(Dimensions.radius20),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductSmallDetails(text: product.name!),
                SizedBox(height: Dimensions.height20),
                BigText(text: 'Details'),
                Expanded(
                  child: SingleChildScrollView(
                    child: ExandableTextWidget(text: product.description!),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.pageViewTextContainer,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20, vertical: Dimensions.height30),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(
                        text: popularProduct.inCartItem.toString(),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$ ${product.price!}" ' | Add to cart',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
