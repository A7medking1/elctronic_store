import 'package:ecommerce_app/size_config.dart';
import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/model/login_model.dart';
import 'package:ecommerce_app/src/view/pages/auth/controller/auth_controller.dart';
import 'package:ecommerce_app/src/view/pages/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/default_button.dart';
import '../../widgets/form_error.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.height20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.font20 + 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height10,
                ),
                const Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.height40,
                ),
                const SignForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  bool showPassword = true;
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
      init: Get.put(AuthController(authRepo: Get.find())),
      builder: (controller) => Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: SizeConfig.height30),
            buildPasswordFormField(),
            SizedBox(height: SizeConfig.height30),
            Row(
              children: [
                Checkbox(
                  value: remember,
                  activeColor: AppConstant().kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  },
                ),
                const Text("Remember me"),
                const Spacer(),
                const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.height20),
            FormError(errors: errors),
            SizedBox(height: SizeConfig.height40),
            !controller.isLoading.value
                ? DefaultButton(
                    text: "Continue",
                    color: Colors.green,
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // if all are valid then go to success screen
                        LoginModel loginModel = LoginModel(
                          userName: email!,
                          password: password!,
                        );

                        await controller.userLogin(loginModel);
                      }
                    },
                  )
                : const CircularProgressIndicator(),
            SizedBox(height: SizeConfig.height40),
            DefaultButton(
              text: "Sign up".toUpperCase(),
              press: () => Get.to(() => const SignUpScreen()),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: showPassword,
      onSaved: (newValue) {
        password = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppConstant().kPassNullError);
        }
         if (value.length > 8) {
          removeError(error: AppConstant().kShortPassError);
        }
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
      decoration:  InputDecoration(
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon:  showPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
          onPressed: ()
          {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ),
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
        /* if (AppConstant().emailValidatorRegExp.hasMatch(value)) {
          removeError(error: AppConstant().kInvalidEmailError);
        }
        return;*/
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppConstant().kEmailNullError);
          return "";
        }
        /* if (!AppConstant().emailValidatorRegExp.hasMatch(value)) {
          addError(error: AppConstant().kInvalidEmailError);
          return "";
        }*/
      },
      decoration: const InputDecoration(
        hintText: "Enter Username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }
}
