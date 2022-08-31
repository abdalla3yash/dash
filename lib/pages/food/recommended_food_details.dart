import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/controllers/recommend_product_controller.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/app_icon.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:dash/widgets/exandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommendedFoodDetails(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendProductController>().recommendProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.offAllNamed(RouteHelper.getInitial());
                    },
                    child: const AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems >= 1
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
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                    child: Center(
                        child: BigText(
                      text: product.name!,
                      size: Dimensions.font26,
                    )))),
            pinned: true,
            expandedHeight: 300,
            backgroundColor: AppColors.yellowColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                '${AppConstant.LAUNCH}/uploads/${product.img!}',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10),
                child: ExandableTextWidget(text: product.description!),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20 * 2.5,
                  vertical: Dimensions.height15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.font26,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.remove),
                  ),
                  BigText(
                    text: "\$${product.price!} "
                        "  X "
                        "${controller.inCartItem}",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.font26,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.add),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.pageViewTextContainer,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width20,
                  vertical: Dimensions.height30),
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      )),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                        text: '\$${product.price!}  | Add to cart',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
