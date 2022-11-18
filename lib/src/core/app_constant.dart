import 'package:flutter/material.dart';

class AppConstant{

   Color kPrimaryColor = const Color(0xFFFF7643);
   Color kPrimaryLightColor = const Color(0xFFFFECDF);
   LinearGradient kPrimaryGradientColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
  );
  Color kSecondaryColor = const Color(0xFF979797);
   Color kTextColor = const Color(0xFF757575);

   Duration kAnimationDuration = const Duration(milliseconds: 200);

  final headingStyle = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );

   Duration defaultDuration = const Duration(milliseconds: 250);

// Form Error
  final RegExp emailValidatorRegExp =RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");



  bool emailValid(String email) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
   String kEmailNullError = "Please Enter your email";
   String kInvalidEmailError = "Please Enter Valid Email";
   String kPassNullError = "Please Enter your password";
   String kShortPassError = "Password is too short";
   String kMatchPassError = "Passwords don't match";
   String kNamelNullError = "Please Enter your name";
   String kPhoneNumberNullError = "Please Enter your phone number";
   String kAddressNullError = "Please Enter your address";


  InputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: kTextColor),
    );
  }


}