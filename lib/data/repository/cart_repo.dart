import 'dart:convert';
import 'package:dash/models/cart_model.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> carthistory = [];
  void addToCartList(List<CartModel> cartList) {
    cart = [];
    var time = DateTime.now().toString();

    // ignore: avoid_function_literals_in_foreach_calls
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstant.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;
    }
    List<CartModel> cartList = [];

    // ignore: avoid_function_literals_in_foreach_calls
    carts.forEach(
      (element) {
        cartList.add(CartModel.fromJson(
          jsonDecode(element),
        ));
      },
    );

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)) {
      carthistory =
          sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];
    // ignore: avoid_function_literals_in_foreach_calls
    carthistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCardHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)) {
      carthistory =
          sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      carthistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstant.CART_HISTORY_LIST, carthistory);
    for (int j = 0; j < getCartHistoryList().length; j++) {}
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstant.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();
    carthistory = [];
    sharedPreferences.remove(AppConstant.CART_HISTORY_LIST);
  }
}
