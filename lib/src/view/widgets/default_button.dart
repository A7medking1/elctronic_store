import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.color,
  }) : super(key: key);
  final String? text;
  final void Function()? press;
  final Color? color ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height:  SizeConfig.height40 + 10,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: color ?? AppConstant().kPrimaryColor,
        ),
        onPressed: press ,
        child: Text(
          text!,
          style:  TextStyle(
            fontSize: SizeConfig.font15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
