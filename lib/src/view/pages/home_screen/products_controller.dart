import 'package:ecommerce_app/src/api_client/repository/products_repo.dart';
import 'package:ecommerce_app/src/view/pages/auth/login_screen.dart';
import 'package:ecommerce_app/src/view/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/favorite_model.dart';
import '../../../model/product_model.dart';




class ProductsController extends GetxController
{
  final ProductsRepo productsRepo;

  ProductsController(this.productsRepo);

  ValueNotifier isLoading = ValueNotifier(false);

  List<ProductModel> products = [];
  List<FavoriteModel> favoriteProductsModel = [];
  List<ProductModel> productByCategory = [];

  Map<int, bool> favorites = {};

  void getProducts() async {
    isLoading.value = true;
    update();
    final result = await productsRepo.getProducts(1);

    if (result.statusCode == 200) {
      products = List<ProductModel>.from(
          (result.data as List).map((e) => ProductModel.fromJson(e)));

      for (var element in products) {
        favorites.addAll({element.id: element.favorite});
      }
    } else {
      Get.offAll(() => const LoginScreen());
      showToast(result.data['detail'], ToastStates.ERROR);
    }
/*
    print(favorites);
*/
    getFavorites();

    isLoading.value = false;
    update();
  }

  void changeFavorite(int id) async {
    favorites[id] = !favorites[id]!;
    update();
    productsRepo.changeFavorite({"id": '$id'}).then((value) {
      showToast(value.data['status'], ToastStates.SUCCESS);
      getFavorites();
    });
  }

  void getFavorites() async {
/*    isLoading.value = true;
    update();*/
    favoriteProductsModel = [];

    final response = await productsRepo.getFavorites();

    if (response.statusCode == 200) {
      favoriteProductsModel = List<FavoriteModel>.from(
          (response.data).map((e) => FavoriteModel.fromJson(e)));
    } else {
      print(response.data);
    }

    update();
  }

  void getProductByCategory(int id) async {
    productByCategory = [];

    isLoading.value = true;
    update();

    final response = await productsRepo.getProductByCategory(id);

    if (response.statusCode == 200) {
      productByCategory = List<ProductModel>.from(
          (response.data as List).map((e) => ProductModel.fromJson(e)));
    } else {
      print(response.data);
    }

    isLoading.value = false;
    update();
  }


  int quantity = 1;

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      quantity = checkQuantity(quantity + 1);
    } else {
      quantity = checkQuantity(quantity - 1);
    }
    update();
  }

  int checkQuantity(int numberQuantity) {
    if (numberQuantity >= 10)
    {
      return 10;
    } else if (numberQuantity <= 1) {
      return 1;
    }
    return numberQuantity;
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
