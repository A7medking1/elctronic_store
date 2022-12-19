import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_constant.dart';
import '../pages/cart_screen/cart_screen.dart';

class CustomAppBarWidget extends StatelessWidget {
  final Widget? actions;

  final String title;

  final bool leadingBack;
  final bool? centerTitle;

  final bool? isCartScreen;

  const CustomAppBarWidget({
    Key? key,
    this.actions,
    required this.title,
    required this.leadingBack,
    this.centerTitle,
    this.isCartScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.lobster(
          fontSize: 20,
          color: Colors.deepOrangeAccent,
        ),
      ),
      centerTitle: centerTitle ?? false,
      leading: leadingBack
          ? Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
            )
          : null,
      actions: [
        !isCartScreen!
            ? Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              IconButton(
                onPressed: () => Get.to(() => const CartScreen()),
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppConstant().kPrimaryColor,
                  size: 30,
                ),
              ),
              const Positioned(
                  child: Text( '0'
                   /* Get.put(CartController(Get.find()))
                        .cartsModel!
                        .data
                        .length
                        .toString() ??
                        ''*/,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  )),
            ],
          ),
        )
            : const SizedBox().marginZero,
        actions ?? const SizedBox().marginZero,

      ],
    );
  }
}
