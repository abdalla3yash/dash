import 'package:dash/base/custom_loader.dart';
import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/controllers/recommend_product_controller.dart';
import 'package:dash/models/product_model.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:dash/utils/colors.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:dash/widgets/bit_text.dart';
import 'package:dash/widgets/icon_and_text_widget.dart';
import 'package:dash/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Product_small_details.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : const CustomLoader();
        }),
        // dots section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: AppColors.mainColor,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius5)),
            ),
          );
        }),
        // popular text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Recommended",
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: SmallText(
                    text: 'Food pairing',
                  )),
            ],
          ),
        ),
        // list of food and images

        GetBuilder<RecommendProductController>(builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProducts.recommendProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (() {
                        Get.toNamed(
                            RouteHelper.getRecommendFood(index, "home"));
                      }),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(children: [
                          // image section
                          Container(
                            height: Dimensions.listViewImage,
                            width: Dimensions.listViewImage,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20,
                              ),
                              color: Colors.white38,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${AppConstant.LAUNCH}/uploads/${recommendedProducts.recommendProductList[index].img!}'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          // text section
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                    Dimensions.radius20,
                                  ),
                                  topRight: Radius.circular(
                                    Dimensions.radius20,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                      text: recommendedProducts
                                          .recommendProductList[index].name!,
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    SmallText(
                                      maxLines: 2,
                                      text: recommendedProducts
                                          .recommendProductList[index]
                                          .description!,
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  })
              : const CustomLoader();
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFood(index, "home"));
        },
        child: Stack(children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? AppColors.mainColor : Colors.amber,
              image: DecorationImage(
                  image: NetworkImage(
                      '${AppConstant.LAUNCH}/uploads/${popularProduct.img!}'),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: ProductSmallDetails(text: popularProduct.name!),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
