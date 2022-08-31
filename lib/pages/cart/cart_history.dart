import 'dart:convert';
import 'package:dash/base/no_data_page.dart';
import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/models/cart_model.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/app_icon.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:dash/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time!)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());

        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(
        text: outputDate,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensions.height45),
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height20 * 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                const AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (controller) {
            return controller.getCartHistoryList().isNotEmpty
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimensions.height30 * 4,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                            itemsPerOrder[i],
                                            (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      width:
                                                          Dimensions.width20 *
                                                              4,
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                              .width10,
                                                          top: Dimensions
                                                              .height5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          Dimensions.radius15 /
                                                              2,
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              '${AppConstant.LAUNCH}/uploads/${getCartHistoryList[index].img!}'),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20 * 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SmallText(
                                                text: "Total",
                                                color: AppColors.titleColor,
                                              ),
                                              BigText(
                                                text:
                                                    "${itemsPerOrder[i].toString()} items",
                                                color: AppColors.titleColor,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () =>
                                                            CartModel.fromJson(
                                                          jsonDecode(
                                                            jsonEncode(
                                                              getCartHistoryList[
                                                                  j],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          Dimensions.height5,
                                                      horizontal:
                                                          Dimensions.width10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius20 /
                                                              2),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor)),
                                                  child: SmallText(
                                                      text: "one more",
                                                      color:
                                                          AppColors.mainColor,
                                                      size: Dimensions.font26 /
                                                          2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const NoDataPage(
                        text: "You didn't buy anything yet!!"));
          })
        ],
      ),
    );
  }
}
