import 'package:dash/pages/cart/cart_page.dart';
import 'package:dash/pages/food/popular_food_details.dart';
import 'package:dash/pages/food/recommended_food_details.dart';
import 'package:dash/pages/home/home_page.dart';
import 'package:dash/pages/home/main_food_page.dart';
import 'package:dash/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendFood = '/recommend-food';
  static const String cartPage = '/cart-page';

  static String getSplash() => splash;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendFood(int pageId, String page) =>
      '$recommendFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
  ];
}
