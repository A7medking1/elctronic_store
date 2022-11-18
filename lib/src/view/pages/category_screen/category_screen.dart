import 'package:ecommerce_app/size_config.dart';
import 'package:ecommerce_app/src/view/pages/category_screen/category_controller.dart';
import 'package:ecommerce_app/src/view/widgets/cached_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      init: Get.put(CategoryController(Get.find())),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
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
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final model = controller.categoryModel[index];

                      return InkWell(
                        onTap: () {
                          ///
                        },
                        child: Card(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CachedImages(
                                //imageUrl: model.image,
                                imageUrl: "http://192.168.1.15:8000${model.image}",
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
