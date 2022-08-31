import 'package:dash/base/custom_loader.dart';
import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/controllers/recommend_product_controller.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dash/helper/dependencies.dart' as dep;

import 'pages/address/add_address_page.dart';

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
            // home: Mapp(),
            initialRoute: RouteHelper.getSplash(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
