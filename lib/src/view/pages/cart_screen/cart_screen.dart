import 'package:ecommerce_app/src/core/api_constant.dart';
import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/view/pages/cart_screen/cart_controller.dart';
import 'package:ecommerce_app/src/view/pages/product_detail_screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/cached_image_network.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/default_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const CustomAppBarWidget(
          title: 'Cart Screen',
          centerTitle: true,
          leadingBack: true,
          isCartScreen: true,
        ),
      ),
      body: GetBuilder<CartController>(
        init: Get.put(CartController(Get.find())),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.cartsModel!.data.isEmpty) {
            return Column(
              children: [
                Center(
                  child: Image(
                    width: 250,
                    height: 250,
                    color: AppConstant().kPrimaryColor,
                    image: const AssetImage(
                      'assets/icons/cart.png',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                FloatingActionButton(
                  onPressed: () => controller.getCart(),
                  child: const Icon(Icons.refresh_outlined),
                )
              ],
            );
          }
          return RefreshIndicator(
            displacement: 100,
            onRefresh: () async => controller.getCart(),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final cartModel = controller.cartsModel!.data[index];
                      return Dismissible(
                        key: ValueKey(cartModel.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection decoration) {
                          controller.deleteProductFromCart(cartModel.id);
                        },
                        background: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.delete,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ProductDetailScreen(
                                productModel: cartModel.product));
                          },
                          child: Card(
                            elevation: 20,
                            shadowColor:
                                AppConstant().kPrimaryColor.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(15)),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.all(15),
                              child: SizedBox(
                                height: 100.0,
                                child: Row(
                                  children: [
                                    CachedImages(
                                      imageUrl: ApiConstant.imagePath(
                                          cartModel.product.image),
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            cartModel.product.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  controller
                                                      .reduceProductInCart(
                                                          cartModel.id);
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 25,
                                                ),
                                              ),
                                              Text(
                                                cartModel.quantity.toString(),
                                                style: const TextStyle(
                                                    fontSize: 25),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  controller
                                                      .increaseProductInCart(
                                                          cartModel.id);
                                                },
                                                child: const Icon(Icons.add,
                                                    size: 25),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.cartsModel!.data.length,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                            'old Price',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          trailing: Text(
                            '${controller.cartsModel!.totalPriceOld}',
                            style: const TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                            'total Price',
                            style: TextStyle(
                              fontSize: 22,
                              color: AppConstant().kPrimaryColor,
                            ),
                          ),
                          trailing: Text(
                            controller.cartsModel!.totalPrice
                                .round()
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: AppConstant().kPrimaryColor,
                            ),
                          ),
                        ),
                        const Divider(),
                        DefaultButton(
                          text: 'Check Out',
                          press: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
