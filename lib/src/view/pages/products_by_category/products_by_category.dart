import 'package:ecommerce_app/src/view/pages/home_screen/home_screen.dart';
import 'package:ecommerce_app/src/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_constant.dart';
import '../../widgets/build_grid_view_product.dart';
import '../home_screen/products_controller.dart';
import '../product_detail_screen/product_detail_screen.dart';

class ProductByCategoryScreen extends StatelessWidget {
  final int categoryId;
  final String title;

  const ProductByCategoryScreen(
      {Key? key, required this.categoryId, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProductsController>().getProductByCategory(categoryId);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBarWidget(title: title, leadingBack: true,centerTitle: true,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<ProductsController>(
          init: Get.find<ProductsController>(),
          builder: (controller) {
            if (controller.productByCategory.isEmpty) {
              return const Center(
                child: Image(
                  image: AssetImage('assets/images/empty.jpg'),
                ),
              );
            }

            return !controller.isLoading.value
                ? GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1.3 / 1.5,
                    children: List.generate(
                      controller.productByCategory.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => ProductDetailScreen(
                                productModel:
                                controller.productByCategory[index]));
                          },
                          // hoverColor: AppConstant().kPrimaryColor,
                          //highlightColor: AppConstant().kPrimaryColor,
                          splashColor: AppConstant().kPrimaryColor,
                          child: BuildGridProduct(
                            productModel: controller.productByCategory[index],
                          ),
                        );
                      },
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
