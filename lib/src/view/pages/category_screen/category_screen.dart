import 'package:ecommerce_app/size_config.dart';
import 'package:ecommerce_app/src/view/pages/category_screen/category_controller.dart';
import 'package:ecommerce_app/src/view/pages/products_by_category/products_by_category.dart';
import 'package:ecommerce_app/src/view/widgets/cached_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/api_constant.dart';
import '../../../core/app_constant.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      init: Get.find<CategoryController>(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Categories",
              style: GoogleFonts.lato(color: Colors.black),
            ),
          ),
          body: !controller.isLoading.value
              ? Padding(
                  padding: EdgeInsets.all(SizeConfig.height10),
                  child: GridView.builder(
                    itemCount: controller.categoryModel.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      final model = controller.categoryModel[index];

                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductByCategoryScreen(categoryId: model.id,title: model.title,));
                        },
                        child: Card(
                          elevation: 20,
                          shadowColor: AppConstant().kPrimaryColor.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(15)
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CachedImages(
                                //imageUrl: model.image,
                                imageUrl: ApiConstant.imagePath(model.image),
                                fit: BoxFit.scaleDown,
                              ),
                              Text(
                                model.title,
                                style: TextStyle(
                                    fontSize: SizeConfig.font15,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
