import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/view/pages/profile_screen/profile_controller.dart';
import 'package:ecommerce_app/src/view/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../size_config.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: Get.find<ProfileController>(),
      builder: (controller) {
        return !controller.isLoading.value
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: controller.userNameController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          controller: controller.emailController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.height170,
                        ),
                        DefaultButton(
                          text: 'Logout'.toUpperCase(),
                          press: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              barrierDismissible: false,
                              confirmBtnColor: AppConstant().kPrimaryColor,
                              animType: QuickAlertAnimType.slideInUp,
                              onConfirmBtnTap: () {
                                controller.logOut();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
