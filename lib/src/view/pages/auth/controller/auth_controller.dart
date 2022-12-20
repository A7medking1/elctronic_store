import 'package:ecommerce_app/src/core/functions/cache_helper.dart';
import 'package:ecommerce_app/src/model/register_model.dart';
import 'package:ecommerce_app/src/view/pages/app_layout.dart';
import 'package:ecommerce_app/src/view/pages/auth/login_screen.dart';
import 'package:ecommerce_app/src/view/pages/cart_screen/cart_controller.dart';
import 'package:ecommerce_app/src/view/pages/category_screen/category_controller.dart';
import 'package:ecommerce_app/src/view/pages/home_screen/products_controller.dart';
import 'package:ecommerce_app/src/view/pages/profile_screen/profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../api_client/repository/auth_repo.dart';
import '../../../../model/login_model.dart';
import '../../../widgets/show_toast.dart';

String token = "";

class AuthController extends GetxController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future userLogin(LoginModel loginModel) async {
    isLoading.value = true;
    update();
    final result = await authRepo.userLogin(loginModel);

    if (result.statusCode == 200)
    {
      token = result.data["token"];

      CacheHelper.saveData(key: 'token', value: result.data["token"]);
      Get.put(ProfileController(Get.find())).getUser();
      Get.put(ProductsController(Get.find())).getFavorites();
      Get.put(ProductsController(Get.find())).getProducts();
      Get.put(CategoryController(Get.find())).getCategory();
     // Get.put(CartController(Get.find())).getCart() ;
      //Get.find<ProductsController>().getProducts();
      Get.find<CategoryController>().getCategory();

      Get.offAll(() => const AppLayout());
    } else {
      isLoading.value = false;
      update();
      print(result.data);
      showToast("Please check your email or password", ToastStates.ERROR);
    }
    isLoading.value = false;
    update();
  }

  Future userRegister(RegisterModel registerModel) async {
    isLoading.value = true;
    update();
    final result = await authRepo.userRegister(registerModel);
    if (result.statusCode == 200) {
      token = result.data["token"];
      showToast("register Successfully", ToastStates.SUCCESS);
      Get.offAll(() => const LoginScreen());
    } else {
      showToast(result.toString(), ToastStates.ERROR);
    }
    isLoading.value = false;
    update();
  }

}
