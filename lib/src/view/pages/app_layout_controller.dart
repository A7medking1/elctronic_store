import 'package:ecommerce_app/src/view/pages/category_screen/category_screen.dart';
import 'package:ecommerce_app/src/view/pages/home_screen/home_screen.dart';
import 'package:ecommerce_app/src/view/pages/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'favorite_screen/favorite_screen.dart';

class AppLayOutController extends GetxController {

  int currentIndex = 0 ;

  void getCurrentIndex(int index) {
    currentIndex = index ;
    update();
  }


  List<Widget> screens = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];



}