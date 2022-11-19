import 'package:ecommerce_app/src/view/pages/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/products_controller.dart';

class ProductByCategoryScreen extends StatelessWidget {
  final int categoryId;

  const ProductByCategoryScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProductsController>().getProductByFavorite(categoryId);
    return Scaffold(
      appBar: AppBar(),
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
                    childAspectRatio: 1.3 / 1.4,
                    children: List.generate(
                      controller.productByCategory.length,
                      (index) {
                        return BuildGridProduct(
                          productModel: controller.productByCategory[index],
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
