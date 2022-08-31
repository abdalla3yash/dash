import 'package:dash/base/custom_loader.dart';
import 'package:dash/controllers/auth_controller.dart';
import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/controllers/user_controller.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/account_widget.dart';
import 'package:dash/widgets/app_icon.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
          title: BigText(
              text: "Profile", color: Colors.white, size: Dimensions.height30),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          return userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height30),
                      child: Column(
                        children: [
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height15 * 5,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.name,
                                      )),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: Colors.green,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.phone,
                                      )),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: Colors.red,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: userController.userModel.email,
                                      )),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on_outlined,
                                        backgroundColor: Colors.blue,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: "Fill in your address",
                                      )),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                        text: "Messages",
                                      )),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      } else {}
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout_rounded,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: "Logout",
                                        )),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height15,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const CustomLoader())
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.height45 * 3,
                          left: Dimensions.width30),
                      child: const Text(" You Must Login"),
                    )
                  ],
                );
        }));
  }
}
