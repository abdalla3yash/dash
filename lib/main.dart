import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/controllers/recommend_product_controller.dart';
import 'package:dash/pages/cart/cart_page.dart';
import 'package:dash/pages/food/popular_food_details.dart';
import 'package:dash/pages/food/recommended_food_details.dart';
import 'package:dash/pages/home/food_page_body.dart';
import 'package:dash/pages/home/main_food_page.dart';
import 'package:dash/pages/splash/splash_page.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dash/helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendProductController>(builder: (_) {
          return GetMaterialApp(
            title: 'dash',
            debugShowCheckedModeBanner: false,
            // home: SplashPage(),
            initialRoute: RouteHelper.getSplash(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
