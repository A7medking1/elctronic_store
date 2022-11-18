import 'package:ecommerce_app/size_config.dart';
import 'package:ecommerce_app/src/core/api_constant.dart';
import 'package:ecommerce_app/src/view/pages/home_screen/products_controller.dart';
import 'package:ecommerce_app/src/view/pages/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/product_model.dart';
import '../../widgets/cached_image_network.dart';
import '../../widgets/custom_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => Get.to(() => SearchScreen()),
                icon: const Icon(
                  Icons.search,
                  size: 30,
                )),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.height10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSlider(),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Products",
                style: TextStyle(
                  fontSize: SizeConfig.font20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GetBuilder<ProductsController>(
                init: Get.find<ProductsController>(),
                builder: (controller) => !controller.isLoading.value
                    ? GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1.3 / 1.3,
                        children: List.generate(
                          controller.products.length,
                          (index) {
                            return BuildGridProduct(
                              productModel: controller.products[index],
                            );
                          },
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildGridProduct extends StatelessWidget {
  final ProductModel productModel;

  const BuildGridProduct({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CachedImages(
              imageUrl: ApiConstant.imagePath(productModel.image),
              fit: BoxFit.contain,
              height: 120,
              width: double.infinity,
            ),
            if (!productModel.discount)
              InkWell(
                onTap: () {
                  Get.find<ProductsController>()
                      .changeFavorite(productModel.id);
                },
                child: CircleAvatar(
                  backgroundColor:
                      Get.find<ProductsController>().favorites[productModel.id]!
                          ? Colors.deepOrange
                          : Colors.grey,
                  radius: 20,
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            if (productModel.discount)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.find<ProductsController>()
                          .changeFavorite(productModel.id);
                    },
                    child: CircleAvatar(
                      backgroundColor: Get.find<ProductsController>()
                              .favorites[productModel.id]!
                          ? Colors.deepOrange
                          : Colors.grey,
                      radius: 20,
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    height: 1.1,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '${productModel.newPrice}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (productModel.discount)
                    Text(
                      '${productModel.oldPrice}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
