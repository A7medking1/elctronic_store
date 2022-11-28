import 'package:ecommerce_app/size_config.dart';
import 'package:ecommerce_app/src/core/api_constant.dart';
import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/view/pages/home_screen/products_controller.dart';
import 'package:ecommerce_app/src/view/pages/product_detail_screen/product_detail_screen.dart';
import 'package:ecommerce_app/src/view/pages/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/product_model.dart';
import '../../widgets/build_grid_view_product.dart';
import '../../widgets/cached_image_network.dart';
import '../../widgets/custom_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ecommerce App",
            style: GoogleFonts.lobster(
                fontSize: 20, color: Colors.deepOrangeAccent)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => Get.to(() => SearchScreen()),
                icon: Icon(
                  Icons.search,
                  color: AppConstant().kPrimaryColor,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products",
                    style: TextStyle(
                      fontSize: SizeConfig.font20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          Text(
                            "See More",
                            style: TextStyle(
                                color: AppConstant().kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppConstant().kPrimaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<ProductsController>(
                init: Get.find<ProductsController>(),
                builder: (controller) {
                  return !controller.isLoading.value
                      ? GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          childAspectRatio: 1.3 / 1.5,
                          children: List.generate(
                            controller.products.length - 13,
                            (index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => ProductDetailScreen(
                                      productModel:
                                          controller.products[index]));
                                },
                                // hoverColor: AppConstant().kPrimaryColor,
                                //highlightColor: AppConstant().kPrimaryColor,
                                splashColor: AppConstant().kPrimaryColor,
                                child: BuildGridProduct(
                                  productModel: controller.products[index],
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

