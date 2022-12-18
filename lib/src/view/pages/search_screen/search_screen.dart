import 'package:ecommerce_app/src/view/pages/search_screen/search_controller.dart';
import 'package:ecommerce_app/src/view/widgets/cached_image_network.dart';
import 'package:ecommerce_app/src/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_constant.dart';
import '../product_detail_screen/product_detail_screen.dart';

class SearchScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(AppBar().preferredSize.height),
          child: const CustomAppBarWidget(title: 'Search', leadingBack: true,centerTitle: true,),
        ),
        body: GetBuilder<SearchController>(
          init: Get.put(SearchController(Get.find())),
          builder: (controller) => Padding(
            padding: const EdgeInsets.only(left: 20, right: 30, top: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: const Icon(Icons.search)),
                    onFieldSubmitted: (text) {
                      if (formKey.currentState!.validate()) {
                        controller.getSearch(text);
                      }
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "please write anything";
                      }
                      return null;
                    },
                  ),
                  if (controller.isLoading.value)
                    const SizedBox(
                      height: 15,
                    ),
                  if (controller.isLoading.value)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 40,
                  ),
                  controller.searchProduct.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              final model = controller.searchProduct[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    () => ProductDetailScreen(
                                      productModel:
                                          controller.searchProduct[index],
                                    ),
                                  );
                                },
                                // hoverColor: AppConstant().kPrimaryColor,
                                //highlightColor: AppConstant().kPrimaryColor,
                                splashColor: AppConstant().kPrimaryColor,
                                child: SizedBox(
                                  height: 100.0,
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment:
                                            AlignmentDirectional.bottomStart,
                                        children: [
                                          CachedImages(
                                            imageUrl: model.image,
                                            height: 120.0,
                                            fit: BoxFit.contain,
                                            width: 120.0,
                                          ),
                                          if (model.discount)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              color: Colors.red,
                                              child: const Text(
                                                'DISCOUNT',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              model.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  height: 1.1,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${model.newPrice}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                if (model.discount)
                                                  Text(
                                                    '${model.oldPrice}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(color: Colors.deepOrange[200]);
                            },
                            itemCount: controller.searchProduct.length,
                          ),
                        )
                      : const Expanded(
                          child: Center(
                            child: Image(
                              width: 250,
                              height: 250,
                              image: AssetImage(
                                'assets/images/search.jpg',
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
