import 'package:dash/controllers/cart_controller.dart';
import 'package:dash/data/repository/popular_product_repo.dart';
import 'package:dash/models/product.dart';
import 'package:dash/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItem = 0;
  int get inCartItem => _inCartItem;
  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar('Item count', "You can't reduce more!!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if (quantity > 20) {
      Get.snackbar('Item count', "You can't add more!!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart) {
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
  }

  void addItem(ProductModel product) {
    if (quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _cart.items.forEach((key, value) {});
    } else {
      Get.snackbar(
          'Item count', "You should at least add an item in the cart!!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
  }
}
