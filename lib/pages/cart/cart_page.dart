import 'package:dash/base/no_data_page.dart';
import 'package:dash/controllers/auth_controller.dart';
import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/controllers/recommend_product_controller.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/app_icon.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:dash/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
          top: Dimensions.height30 * 1.5,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
              SizedBox(width: Dimensions.width20 * 6),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(RouteHelper.getInitial());
                },
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (cartController) {
          return cartController.getItems.isNotEmpty
              ? Positioned(
                  top: Dimensions.height20 * 4,
                  bottom: 0,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    color: Colors.white54,
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    child: MediaQuery.removePadding(
                      context: context,
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        var cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimensions.height20 * 5,
                                width: double.maxFinite,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    cartList[index].product!);
                                        if (popularIndex >= 0) {
                                          Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                  popularIndex, "cartpage"));
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendProductController>()
                                              .recommendProductList
                                              .indexOf(
                                                  cartList[index].product!);

                                          if (recommendedIndex < 0) {
                                            Get.snackbar("History product",
                                                "product review is not available for history products",
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white);
                                          } else {
                                            Get.toNamed(
                                              RouteHelper.getRecommendFood(
                                                recommendedIndex,
                                                "cartpage",
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.width20 * 5,
                                        height: Dimensions.height20 * 5,
                                        decoration: BoxDecoration(
                                          color: Colors.white54,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${AppConstant.LAUNCH}/uploads/${cartController.getItems[index].img!}'),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.width10,
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      height: Dimensions.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartController
                                                .getItems[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(
                                            text: "Spicy",
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].price!
                                                    .toString(),
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width20,
                                                    vertical:
                                                        Dimensions.height10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            cartList[index]
                                                                .product!,
                                                            -1);
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2,
                                                    ),
                                                    BigText(
                                                      text: cartList[index]
                                                          .quantity
                                                          .toString(),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            cartList[index]
                                                                .product!,
                                                            1);
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              );
                            });
                      }),
                    ),
                  ),
                )
              : const NoDataPage(text: "Your Card Is Empty!!");
        })
      ]),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
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
          child: controller.getItems.isNotEmpty
              ? Row(
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
                        child: BigText(
                          text: " ${controller.totalAmount.toString()} \$",
                        )),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          controller.addToHistory();
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
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
                          text: 'Check out',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        );
      }),
    );
  }
}
