import 'dart:async';

import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/controllers/recommend_product_controller.dart';
import 'package:dash/routes/route_helper.dart';
import 'package:dash/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendProductController>().getRecommendProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ScaleTransition(
              scale: animation,
              child: Container(
                height: Dimensions.height45 * 10,
                width: Dimensions.height45 * 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius20,
                    ),
                    color: Colors.white38,
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-vector/good-food-logo-template_79169-17.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
