import 'package:ecommerce_app/src/api_client/ApiClient.dart';
import 'package:ecommerce_app/src/core/binding/binding.dart';
import 'package:ecommerce_app/src/core/functions/cache_helper.dart';
import 'package:ecommerce_app/src/view/pages/app_layout.dart';
import 'package:ecommerce_app/src/view/pages/auth/controller/auth_controller.dart';
import 'package:ecommerce_app/src/view/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token') ?? "";
  print(token);
  ApiClient.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.deepOrange,
      ),
      initialBinding: AppBinding(),
      home: token == "" ?  const LoginScreen() : const AppLayout(),
    );
  }
}

