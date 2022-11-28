import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/view/pages/app_layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLayOutController>(
      init: Get.put(AppLayOutController()),
      builder: (controller) => Scaffold(
        body: controller.screens[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) => controller.getCurrentIndex(index),
          elevation: 100,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.grey.shade100,
          items: [
            BottomNavigationBarItem(
              //  backgroundColor: Colors.grey.shade900,
              activeIcon: const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset(
                  'assets/icons/home.svg',
                  fit: BoxFit.contain,
                  color: AppConstant().kPrimaryColor,
                  width: 20,
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Category",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset(
                  'assets/icons/category.svg',
                  fit: BoxFit.contain,
                  color: AppConstant().kPrimaryColor,
                  width: 20,
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Favorite",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  fit: BoxFit.contain,
                  color: AppConstant().kPrimaryColor,
                  width: 20,
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Setting",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset(
                  'assets/icons/setting.svg',
                  fit: BoxFit.contain,
                  color: AppConstant().kPrimaryColor,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
