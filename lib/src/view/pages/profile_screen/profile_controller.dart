import 'package:dio/dio.dart';
import 'package:ecommerce_app/src/core/api_constant.dart';
import 'package:ecommerce_app/src/core/functions/cache_helper.dart';
import 'package:ecommerce_app/src/model/user_model.dart';
import 'package:ecommerce_app/src/view/pages/app_layout_controller.dart';
import 'package:ecommerce_app/src/view/pages/auth/login_screen.dart';
import 'package:ecommerce_app/src/view/widgets/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api_client/repository/products_repo.dart';
import '../auth/controller/auth_controller.dart';

class ProfileController extends GetxController {
  ValueNotifier isLoading = ValueNotifier(false);

  ProductsRepo productsRepo;

  ProfileController(this.productsRepo);

  UserModel? userModel;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void getUser() async {
    isLoading.value = true;
    update();
    final response = await productsRepo.getCurrentUser();
    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(response.data);
      userNameController.text = userModel!.userName;
      emailController.text = userModel!.email;
    } else {
      showToast("body", ToastStates.ERROR);
    }

    isLoading.value = false;
    update();
  }

  void logOut() async {
    isLoading.value = true;
    update();
    final result = await Dio().post('${ApiConstant.baseUrl}/api/logoutall/',
        options: Options(headers: {'Authorization': 'token $token'}));
    await CacheHelper.removeData(key: 'token');
    if (result.statusCode == 204) {
      Get.offAll(() => const LoginScreen());

      Get.find<AppLayOutController>().currentIndex = 0;
    } else {}

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
