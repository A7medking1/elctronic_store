import 'package:ecommerce_app/src/view/pages/app_layout_controller.dart';
import 'package:ecommerce_app/src/view/pages/category_screen/category_controller.dart';
import 'package:ecommerce_app/src/view/pages/profile_screen/profile_controller.dart';
import 'package:ecommerce_app/src/view/pages/search_screen/search_controller.dart';
import 'package:get/get.dart';

import '../../api_client/ApiClient.dart';
import '../../api_client/repository/auth_repo.dart';
import '../../api_client/repository/products_repo.dart';
import '../../view/pages/auth/controller/auth_controller.dart';
import '../../view/pages/home_screen/products_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiClient());

    /// repository
    Get.put(AuthRepo(apiClient: Get.find<ApiClient>()));
    Get.put(ProductsRepo(Get.find<ApiClient>()));

    /// controller
    Get.lazyPut<AuthController>(
        () => AuthController(authRepo: Get.find<AuthRepo>()));
    Get.lazyPut(() => AppLayOutController());
    Get.lazyPut(() => CategoryController(Get.find<ProductsRepo>()));
    Get.lazyPut(() => ProfileController(Get.find<ProductsRepo>()));
    Get.lazyPut(() => ProductsController(Get.find<ProductsRepo>()));
   // Get.lazyPut(() => SearchController(Get.find<ProductsRepo>()));
  }
}
