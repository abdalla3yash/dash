import 'package:dash/controllers/auth_controller.dart';
import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/controllers/location_controller.dart';
import 'package:dash/controllers/popular_product_controller.dart';
import 'package:dash/controllers/user_controller.dart';
import 'package:dash/data/api/api_client.dart';
import 'package:dash/data/repository/auth_repo.dart';
import 'package:dash/data/repository/cart_repo.dart';
import 'package:dash/data/repository/location_repo.dart';
import 'package:dash/data/repository/popular_product_repo.dart';
import 'package:dash/data/repository/recommend_product_repo.dart';
import 'package:dash/data/repository/user_repo.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommend_product_controller.dart';

Future<void> init() async {
  // local user data
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // api client
  Get.lazyPut(() =>
      ApiClient(appBaseURL: AppConstant.LAUNCH, sharedPreferences: Get.find()));
  // repos
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));

  Get.lazyPut(
      () => RecommendProductController(recommendProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
