import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/api_constant.dart';
import '../../core/app_constant.dart';
import '../../model/product_model.dart';
import '../pages/home_screen/products_controller.dart';
import 'cached_image_network.dart';

class BuildGridProduct extends StatelessWidget {
  final ProductModel productModel;

  const BuildGridProduct({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shadowColor: AppConstant().kPrimaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
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
              if (productModel.discount)
                Row(
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
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.find<ProductsController>()
                            .changeFavorite(productModel.id);
                      },
                      child: Container(
                        alignment: AlignmentDirectional.bottomEnd,
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
                      'EGP ${productModel.newPrice}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppConstant().kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (productModel.discount)
                      Expanded(
                        child: Text(
                          '${productModel.oldPrice}',
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
