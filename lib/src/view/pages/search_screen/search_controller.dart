import 'package:ecommerce_app/src/api_client/repository/products_repo.dart';
import 'package:ecommerce_app/src/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SearchController extends GetxController {
  final ProductsRepo productsRepo;

  SearchController(this.productsRepo);

  ValueNotifier isLoading = ValueNotifier(false);

  List<ProductModel> searchProduct = [];

  void getSearch(String text) async {
    searchProduct = [];
    isLoading.value = true;
    update();

    final response = await productsRepo.searchProducts(text);

    if (response.statusCode == 200) {
      searchProduct = List<ProductModel>.from(
          (response.data as List).map((e) => ProductModel.fromJson(e)));
    } else {
      print(response.data);
    }

    isLoading.value = false;
    update();
  }
}
