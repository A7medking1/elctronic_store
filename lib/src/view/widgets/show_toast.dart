import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ToastStates { SUCCESS, ERROR, WARNING }

void showToast(String body, ToastStates state) {
  Get.snackbar(
    body,
    "",
    colorText: Colors.white,
    titleText: Center(
        child: Text(
      body,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
    )),
    backgroundColor: chooseToastColor(state),
    duration: const Duration(milliseconds: 700),
    snackPosition: SnackPosition.BOTTOM,
  );
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.deepOrangeAccent;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
