import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarWidget extends StatelessWidget {

  final List<Widget>? actions ;
  final String  title ;
  final bool leadingBack;
  final bool? centerTitle ;



  const CustomAppBarWidget({
    Key? key, this.actions, required this.title, required this.leadingBack, this.centerTitle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: GoogleFonts.lobster(
          fontSize: 20, color: Colors.deepOrangeAccent,),),
      centerTitle: centerTitle ?? false,
      leading: leadingBack ? Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
      ) : null,
      actions: actions,
    );
  }
}
