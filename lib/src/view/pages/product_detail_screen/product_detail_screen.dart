import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_app/src/core/api_constant.dart';
import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/cached_image_network.dart';
import '../home_screen/products_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    Get.find<ProductsController>().quantity = 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(productModel: productModel),
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
          from: 50,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: CachedImages(
                        width: double.maxFinite,
                        imageUrl: !productModel.image.contains("http://")
                            ? ApiConstant.imagePath(
                                productModel.image,
                              )
                            : productModel.image,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const Text(
                      "EGP ",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "${productModel.newPrice.round()}",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: AppConstant().kPrimaryColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${productModel.oldPrice}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  productModel.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Description :",
                  style: TextStyle(
                      color: AppConstant().kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  productModel.description,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadiusDirectional.only(
          topEnd: Radius.circular(40),
          topStart: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -10),
            color: Colors.deepOrangeAccent.withOpacity(0.15),
            blurRadius: 40,
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsetsDirectional.only(bottom: 20, start: 20, end: 30),
        child: GetBuilder<ProductsController>(
          init: Get.find<ProductsController>(),
          builder: (controller) =>  Row(
            children: [
              TextButton(
                onPressed: () => controller.setQuantity(false),
                child: const Icon(Icons.remove, size: 40),
              ),
              const SizedBox(
                width: 5,
              ),
               Text(
                controller.quantity.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                onPressed: () => controller.setQuantity(true),
                child: const Icon(Icons.add, size: 40),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: AppConstant().kPrimaryColor,
                    borderRadius: BorderRadiusDirectional.circular(25)),
                height: 70,
                width: 120,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Add To Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Colors.grey,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
      ),
      actions: [
        GetBuilder(
          init: Get.find<ProductsController>(),
          builder: (controller) => InkWell(
            onTap: () {
              controller.changeFavorite(productModel.id);
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 20, top: 10),
              child: CircleAvatar(
                backgroundColor: controller.favorites[productModel.id]!
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
          ),
        ),
      ],
    );
  }
}
