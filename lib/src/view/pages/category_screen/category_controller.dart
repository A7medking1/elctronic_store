import 'package:ecommerce_app/src/api_client/repository/products_repo.dart';
import 'package:ecommerce_app/src/view/widgets/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/category_model.dart';

class CategoryController extends GetxController {
  final ProductsRepo productsRepo;

  CategoryController(this.productsRepo);

  ValueNotifier isLoading = ValueNotifier(false);

  List<CategoryModel> categoryModel = [];

  void getCategory() async {
    categoryModel = [];
    isLoading.value = true;
    update();
    final response = await productsRepo.getCategories();
    if (response.statusCode == 200) {
      categoryModel = List<CategoryModel>.from(
          (response.data as List).map((e) => CategoryModel.fromJson(e)));
    } else {
      showToast(response.toString(), ToastStates.ERROR);
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }
}
