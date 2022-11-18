import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/view/pages/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../size_config.dart';
import '../../../model/register_model.dart';
import '../../widgets/default_button.dart';
import '../../widgets/form_error.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            SizeConfig.height20,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Register Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.font20 + 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height10 - 5,
                ),
                const Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.height40,
                ),
                const SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? userName;
  String? password;
  String? conformPassword;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.find<AuthController>(),
      builder: (controller) => Form(
        key: _formKey,
        child: Column(
          children: [
            buildUserNameFormField(),
            SizedBox(height: SizeConfig.height40),
            buildEmailFormField(),
            SizedBox(height: SizeConfig.height40),
            buildPasswordFormField(),
            SizedBox(height: SizeConfig.height40),
            buildConformPassFormField(),
            FormError(errors: errors),
            SizedBox(height: SizeConfig.height40),
            !controller.isLoading.value ? DefaultButton(
              text: "Continue",
              press: () async {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  /// sign up here

                  RegisterModel registerModel = RegisterModel(
                    userName: userName!,
                    email: email!,
                    password: password!,
                  );
                  await controller.userRegister(registerModel);
                }
              },
            ): const Center(child: CircularProgressIndicator(),),
          ],
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) {
        conformPassword = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstant().kPassNullError);
        }
        if (password == value) {
          removeError(error: AppConstant().kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstant().kPassNullError);
          return "";
        }
        if (password != conformPassword) {
          addError(error: AppConstant().kMatchPassError);
          return "";
        }
      },
      decoration: const InputDecoration(
          hintText: "Re-enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(Icons.lock)),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) {
        password = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstant().kPassNullError);
        }
        if (value.length >= 8) {
          removeError(error: AppConstant().kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstant().kPassNullError);
          return "";
        }
        if (value.length < 8) {
          addError(error: AppConstant().kShortPassError);
          return "";
        }
      },
      decoration: const InputDecoration(
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {
        email = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstant().kEmailNullError);
        }
        if (AppConstant().emailValidatorRegExp.hasMatch(value)) {
          removeError(error: AppConstant().kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstant().kEmailNullError);
          return "";
        }
        if (!AppConstant().emailValidatorRegExp.hasMatch(value)) {
          addError(error: AppConstant().kInvalidEmailError);
          return "";
        }
      },
      decoration: const InputDecoration(
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) {
        userName = newValue;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Username".toUpperCase();
        }
      },
      decoration: const InputDecoration(
        hintText: "Enter your User Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}
