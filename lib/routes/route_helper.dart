import 'package:dash/pages/address/add_address_page.dart';
import 'package:dash/pages/auth/sign_in_page.dart';
import 'package:dash/pages/cart/cart_page.dart';
import 'package:dash/pages/food/popular_food_details.dart';
import 'package:dash/pages/food/recommended_food_details.dart';
import 'package:dash/pages/home/home_page.dart';
import 'package:dash/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splash = '/splash';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendFood = '/recommend-food';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';
  static const String addAddress = '/add-address';

  static String getSplash() => splash;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendFood(int pageId, String page) =>
      '$recommendFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getSignInPage() => signIn;

  static String getAddressPage() => addAddress;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: signIn,
        page: () => const SignInPage(),
        transition: Transition.fade),
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
    GetPage(
        name: addAddress,
        page: () {
          return const AddAddressPage();
        },
        transition: Transition.fadeIn),
  ];
}
