import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_constant.dart';
import '../../widgets/build_grid_view_product.dart';
import '../home_screen/home_screen.dart';
import '../home_screen/products_controller.dart';
import '../product_detail_screen/product_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<ProductsController>(
        init: Get.find<ProductsController>(),
        builder: (controller) {
          if (controller.favoriteProductsModel.isEmpty) {
            return const Center(
              child: Image(
                image: AssetImage('assets/images/empty.jpg'),
              ),
            );
          }
          return !controller.isLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1.3 / 1.5,
                    children: List.generate(
                      controller.favoriteProductsModel.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => ProductDetailScreen(
                                productModel:
                                controller.favoriteProductsModel[index].product));
                          },
                          // hoverColor: AppConstant().kPrimaryColor,
                          //highlightColor: AppConstant().kPrimaryColor,
                          splashColor: AppConstant().kPrimaryColor,
                          child: BuildGridProduct(
                            productModel:
                                controller.favoriteProductsModel[index].product,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

/*
class BuildGridProduct extends StatelessWidget {
  final FavoriteModel favoriteModel;

  const BuildGridProduct({Key? key, required this.favoriteModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shadowColor: AppConstant().kPrimaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CachedImages(
                imageUrl: ApiConstant.imagePath(favoriteModel.product.image),
                fit: BoxFit.contain,
                height: 120,
                width: double.infinity,
              ),
              InkWell(
                onTap: () {
                  Get.find<ProductsController>()
                      .changeFavorite(favoriteModel.product.id);
                },
                child: CircleAvatar(
                  backgroundColor: Get.find<ProductsController>()
                          .favorites[favoriteModel.product.id]!
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favoriteModel.product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.1,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'EGP ${favoriteModel.product.newPrice}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (favoriteModel.product.discount)
                      Expanded(
                        child: Text(
                          '${favoriteModel.product.oldPrice}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
