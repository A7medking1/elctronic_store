import 'package:ecommerce_app/src/api_client/repository/products_repo.dart';
import 'package:ecommerce_app/src/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/show_toast.dart';

class CartController extends GetxController {
  final ProductsRepo productsRepo;

  CartController(this.productsRepo);

  ValueNotifier isLoading = ValueNotifier(false);

  CartsModel? cartsModel;

  void addToCart({int? prodId, int? quantity}) async {
    final result = await productsRepo.addProductToCart({
      'product_id': prodId,
      'quantity': quantity,
    });
    if (result.data['status'] == "added to cart successfully") {
      Get.defaultDialog(title: "status", middleText: result.data['status']);
    } else if (result.data['status'] == "already in cart") {
      Get.defaultDialog(title: "status", middleText: result.data['status']);
    } else {
      showToast(result.data['status'], ToastStates.ERROR);
    }
  }

  void getCart() async {
    isLoading.value = true;
    update();
    final response = await productsRepo.getCarts();
    if (response.statusCode == 200) {
      cartsModel = CartsModel.fromJson(response.data);
    } else {}
    isLoading.value = false;
    update();
  }

  void increaseProductInCart(int id) async {
    final response = await productsRepo.increaseProductInCart(id);

    if (response.statusCode == 200) {
      Get.defaultDialog(title: "status", middleText: response.data['detail']);
    }

    update();
    getCart();
  }

  void reduceProductInCart(int id) async {
    final response = await productsRepo.reduceProductInCart(id);
    if (response.statusCode == 200) {
      Get.defaultDialog(title: "status", middleText: response.data['detail']);
    }
    update();
    getCart();
  }

  void deleteProductFromCart(int id) async {
    final response = await productsRepo.deleteProductFromCart(id);
    if (response.statusCode == 200) {
      Get.defaultDialog(title: "status", middleText: response.data['detail']);
    }
    update();
    getCart();
  }

  @override
  void onInit() {
    super.onInit();
    getCart();
  }
}
