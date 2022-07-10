import 'package:dash/pages/food/popular_food_details.dart';
import 'package:dash/pages/food/recommended_food_details.dart';
import 'package:dash/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String popularFood = '/popular-food';

  static const String recommendFood = '/recommend-food';

  static String getInitial() => initial;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static String getRecommendFood(int pageId) => '$recommendFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
  ];
}
