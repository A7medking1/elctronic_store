import 'package:ecommerce_app/src/api_client/repository/products_repo.dart';
import 'package:ecommerce_app/src/view/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/favorite_model.dart';
import '../../../model/product_model.dart';

class ProductsController extends GetxController {
  final ProductsRepo productsRepo;

  ProductsController(this.productsRepo);

  ValueNotifier isLoading = ValueNotifier(false);

  List<ProductModel> products = [];
  List<FavoriteModel> favoriteProductsModel = [];

  Map<int, bool> favorites = {};

  void getProducts() async {
    isLoading.value = true;
    update();
    final result = await productsRepo.getProducts(1);

    if (result.statusCode == 200) {
      products = List<ProductModel>.from((result.data['results'] as List)
          .map((e) => ProductModel.fromJson(e)));

      for (var element in products) {
        favorites.addAll({element.id: element.favorite});
      }
    } else {
      showToast("Error", ToastStates.ERROR);
    }
    isLoading.value = false;
    update();
  }

  void changeFavorite(int id) async {
    favorites[id] = !favorites[id]!;
    update();
    productsRepo.changeFavorite({"id": '$id'}).then((value) {
      showToast(value.data['status'], ToastStates.SUCCESS);

      if (favorites[id] == false) {
        print("yes");
        getFavorites();
      }
    });
  }

  void getFavorites() async {
    isLoading.value = true;
    update();
    favoriteProductsModel = [];

    final response = await productsRepo.getFavorites();

    if (response.statusCode == 200) {
      favoriteProductsModel = List<FavoriteModel>.from(
          (response.data).map((e) => FavoriteModel.fromJson(e)));
    } else {
      print(response.data);
    }

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    getProducts();
    getFavorites();
    super.onInit();
  }
}
